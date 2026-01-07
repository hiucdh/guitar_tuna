# Phân Tích Kỹ Thuật Dự Án Guitar Tuna

Tài liệu này dùng để hỗ trợ thuyết trình về dự án, tập trung vào kiến trúc hệ thống, thuật toán xử lý âm thanh và chất lượng mã nguồn.

---

## 1. Tổng Quan Dự Án (Project Overview)
- **Tên dự án**: Guitar Tuna (Clone)
- **Nền tảng**: Mobile (Flutter - iOS/Android)
- **Mục tiêu**: Ứng dụng hỗ trợ lên dây đàn (Tuner) theo thời gian thực với độ chính xác cao.

---

## 2. Kiến Trúc Phần Mềm (Clean Architecture)
Dự án áp dụng mô hình **Clean Architecture** kết hợp với **Provider** để quản lý trạng thái, đảm bảo tính tách biệt, dễ bảo trì và mở rộng.

### Mô hình 3 lớp (3-Layer Architecture):

#### A. Data Layer (Lớp Dữ Liệu)
- **Trách nhiệm**: Xử lý nguồn dữ liệu và tương tác với phần cứng (Microphone).
- **Thành phần chính**:
    - `AudioService`: Wrapper cho các thư viện bên thứ 3 (`flutter_audio_capture`, `pitch_detector_dart`).
    - `AudioRepositoryImpl`: Triển khai interface của Domain, cầu nối giữa Service và Domain.
- **Code highlight**: Sử dụng `StreamController` để broadcast dữ liệu âm thanh liên tục.

#### D. Infrastructure Layer (Thư mục Services)
Đây là các logic giao tiếp với Hệ điều hành hoặc các tác vụ nền, độc lập với nghiệp vụ (Domain):
- `audio/`: Điều khiển Microphone, lấy mẫu âm thanh.
- `permission/`: Xin quyền truy cập Microphone hệ thống.
- `storage/`: Lưu cấu hình người dùng (Shared Preferences).
- `metronome/`: Bộ đếm nhịp (Metronome) chạy background.

#### B. Domain Layer (Lớp Nghiệp Vụ - The Core)
- **Trách nhiệm**: Chứa các business logic thuần túy, không phụ thuộc vào UI hay Framework.
- **Thành phần chính**:
    - **Entities**: `Note`, `Tuning`, `Chord` - Các object mô tả dữ liệu lõi.
    - **Use Cases**:
        - `DetectPitch`: Kích hoạt việc lắng nghe cao độ.
        - `GetClosestNote`: Thuật toán tìm nốt nhạc gần nhất từ tần số.
        - `CalculateCents`: Tính độ lệch pha (độ chuẩn) của dây đàn.
    - **Interfaces**: `AudioRepository` - Định nghĩa chuẩn giao tiếp.

#### C. Presentation Layer (Lớp Giao Diện)
- **Trách nhiệm**: Hiển thị UI và phản hồi người dùng.
- **State Management**: Sử dụng **Provider** (`TunerProvider`).
    - Provider đóng vai trò như ViewModel.
    - Lắng nghe Stream từ Domain, cập nhật state (`detectedFrequency`, `tuningStatus`) và `notifyListeners()` để UI rebuild.

### D. Phạm vi hoạt động (Operating Range)
Dựa trên cấu hình `SampleRate: 44100Hz` và `BufferSize: 2000`:
- **Giải tần số (Frequency Range)**:
    - **Lý thuyết**: Có thể bắt được từ ~22Hz (do buffer size) đến ~22050Hz (Nyquist frequency).
    - **Thực tế ổn định**: Từ **27.5 Hz** (A0 - Nốt thấp nhất Piano) đến **4186 Hz** (C8 - Nốt cao nhất Piano).
- **Giải nốt nhạc (Note Range)**:
    - Code hỗ trợ chuyển đổi toán học cho toàn bộ giải MIDI (0-127).
    - **Guitar 6 dây chuẩn**: Từ **E2 (82.41 Hz)** đến khoảng **E5/E6 (~660-1300 Hz)**.
    - Ứng dụng này có thể dùng cho cả Bass (E1 ~ 41Hz) và Ukulele vì giải tần số bao trùm được hầu hết nhạc cụ dây.

---

## 3. Quy Trình & Thuật Toán Xử Lý Âm Thanh (Core Algorithms)

Hệ thống hoạt động theo quy trình Pipeline (Đường ống) như sau:

### Bước 1: Thu thập tín hiệu (Audio Capture)
- Sử dụng `flutter_audio_capture` để lấy mẫu tín hiệu âm thanh thô (Raw PCM Data) từ Microphone.
- **Cấu hình**: Sample Rate: 44100Hz, Buffer Size: 2000-3000.
- Dữ liệu trả về dưới dạng mảng `Float32List` (biên độ dao động sóng âm).

### Bước 2: Phát hiện cao độ (Pitch Detection)
> [!NOTE]
> **Quan trọng**: Phần này dự án sử dụng thư viện `pitch_detector_dart`. Chúng ta KHÔNG tự viết thuật toán biến đổi Fourier (FFT) hay YIN từ con số 0, mà gọi hàm API của thư viện để xử lý tín hiệu. Điều này đảm bảo hiệu năng tối ưu (viết bằng C++ ở tầng dưới hoặc Dart tối ưu).

- Dữ liệu thô được đưa vào `PitchDetector`.
- **Thuật toán bên trong**: Thư viện này sử dụng thuật toán **McLeod Pitch Method (MPM)** hoặc **YIN** (tùy phiên bản).
    - Đây là thuật toán xác định chu kỳ (Time-domain) thay vì tần số (Frequency-domain như FFT), giúp độ trễ thấp hơn và chính xác hơn cho đơn âm (monophonic) như Guitar.
- **Input**: Buffer âm thanh (Time Domain).
- **Output**: Tần số (Frequency) đơn vị Hz (ví dụ: 440.0 Hz).

### Bước 3: Phân tích Nốt nhạc (Digital Signal Processing Logic)
Logic này nằm trong UseCase `GetClosestNote`.

1.  **Chuyển đổi tần số sang MIDI Number**:
    Công thức toán học để tìm nốt MIDI gần nhất:
    $$ n = 69 + 12 \times \log_2\left(\frac{f}{440}\right) $$
    *(Trong đó $f$ là tần số thu được, 440Hz là nốt La chuẩn A4)*.

2.  **Mapping MIDI sang Note Name & Octave**:
    - `Note Name` = Các nốt trong 1 quãng 8 (C, C#, D, D#, E, F, F#, G, G#, A, A#, B).
    - `Octave` = Bát độ (cao độ của quãng).

3.  **Tính độ lệch (Cents Calculation)** - UseCase `CalculateCents`:
    Để biết dây đàn đang *Căng (Sharp)* hay *Chùng (Flat)*, ta tính đơn vị **Cent**:
    $$ cents = 1200 \times \log_2\left(\frac{f_{measured}}{f_{target}}\right) $$
    - Nếu `cents` gần 0: Dây chuẩn (In Tune).
    - `cents > 0`: Dây quá căng -> Cần xả dây.
    - `cents < 0`: Dây quá chùng -> Cần căng dây.

---

## 4. Code Quality & Clean Code (Điểm cộng kỹ thuật)

Để đạt điểm tối đa, hãy nhấn mạnh các yếu tố sau trong Codebase:

1.  **Separation of Concerns (Phân tách mối quan tâm)**:
    - Logic tính toán toán học (`GetClosestNote`) tách biệt hoàn toàn với logic lấy mẫu âm thanh (`AudioService`).
    - UI không chứa logic tính toán, chỉ hiển thị dữ liệu từ Provider.

2.  **Functional Error Handling**:
    - Sử dụng kiểu dữ liệu `Either<Failure, Success>` (từ thư viện `dartz`) thay vì `try-catch` lồng nhau lộn xộn. Giúp code luồng chính (happy path) rõ ràng và bắt buộc phải xử lý lỗi biên.

3.  **Dependency Injection (DI)**:
    - Các class không tự khởi tạo dependency của mình mà được tiêm vào (Inject) qua Constructor (trong `TunerProvider`). Giúp dễ dàng viết Unit Test (Mocking repositories).

4.  **Extension Methods**:
    - Sử dụng Extension (`double_extension.dart`) để mở rộng chức năng cho các kiểu dữ liệu cơ bản (ví dụ: `.toMidiNote()` trên kiểu `double`), giúp code đọc giống như ngôn ngữ tự nhiên.

---

## 5. Bản đồ Mã nguồn (Source Code Map)

Dưới đây là danh sách các file quan trọng tương ứng với từng chức năng để bạn demo hoặc show code:

### A. Core Audio Logic (Xử lý âm thanh & Thuật toán)
| Chức năng | File Path | Mô tả |
| :--- | :--- | :--- |
| **Audio Capture** | `lib/services/audio/audio_service.dart` | Cấu hình Microphone, Stream âm thanh thô. |
| **Pitch Detection** | `lib/domain/usecases/detect_pitch.dart` | Gọi thư viện để lấy tần số Pitch. |
| **Note Calculation** | `lib/domain/usecases/get_closest_note.dart` | **Quan Trọng**: Thuật toán chuyển đổi Hz -> Note & Octave. |
| **Cents Calculation** | `lib/domain/usecases/calculate_cents.dart` | Tính độ lệch chuẩn của dây đàn. |

### B. Architecture Components (Kiến trúc hệ thống)
| Thành phần | File Path | Vai trò |
| :--- | :--- | :--- |
| **Entity (Model)** | `lib/domain/entities/note.dart` | Định nghĩa object `Note` (tần số, tên, octave). |
| **Repository Impl** | `lib/data/repositories/audio_repository_impl.dart` | Kết nối Data Layer với Domain Layer. |
| **State Management** | `lib/presentation/providers/tuner_provider.dart` | **Quan Trọng**: Logic trung tâm kết nối UI và thuật toán. Nơi xử lý dữ liệu để hiển thị. |

### C. UI Components (Giao diện)
| Màn hình | File Path | Mô tả |
| :--- | :--- | :--- |
| **Tuner Screen** | `lib/presentation/screens/tuner/tuner_screen.dart` | Màn hình chính của Tuner. |
| **UI Widgets** | `lib/presentation/widgets/tuner/` | Thư mục chứa các thành phần giao diện nhỏ của Tuner (kim đo, hiển thị nốt). |

---

## 6. Tổng kết
Dự án không chỉ là một ứng dụng Tuner đơn thuần mà là một ví dụ điển hình của việc áp dụng kỹ thuật phần mềm bài bản (Clean Architecture) vào xử lý tín hiệu thực (Real-time Signal Processing) trên nền tảng di động.
