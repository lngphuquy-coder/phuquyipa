# ⚡ ONYXZ SYSTEM - BỘ CÔNG CỤ TẠO KEY BẢN QUYỀN (IOS .IPA)

Dự án này đã được code đầy đủ và cấu hình sẵn thành gói cài đặt cho iOS (hỗ trợ đóng gói thành file **`.ipa`** cài qua **ESign / TrollStore / AltStore**).

---

## 📁 Cấu trúc dự án bên trong thư mục `ios_app`:

1. **`src/main.mm`**: Mã nguồn C++ / Objective-C++ điều khiển ứng dụng iOS toàn màn hình, tích hợp thuật toán sinh Key lõi `ONYXZ-` ngẫu nhiên.
2. **`index.html`**: Giao diện ứng dụng hoàn chỉnh:
   - **Splash Screen 5 giây**: Hoạt họa sóng biển nhấp nhô mượt mà, chữ `ONYXZ SYSTEM` lướt từ trái sang phải, đàn chim 6 con bay lượn trên chữ, thanh đếm loading 5s.
   - **Giao diện chính Dark Theme**: Nền tối siêu đẹp chuyển động (Cyberpunk obsidian), đàn chim 6 con tiếp tục bay lượn ở nền phía sau.
   - **Tab 1 - Tạo Key**: Chọn 5 thời hạn (1 Giờ, 1 Ngày, 1 Tuần, 1 Tháng, Vĩnh Viễn). Ô nhập số thiết bị (mặc định 1 - 1 máy nhập thì máy khác không nhập được). Ô tạo số lượng lớn (1 đến 50 key, mỗi key 1 dòng, nút Sao chép tất cả).
   - **Tab 2 - Lịch sử**: Lưu toàn bộ lịch sử key đã tạo, có nút **Xóa Key** (khi bấm xóa, key lập tức bị khóa, không máy nào có thể nhập được nữa).
   - **Tab 3 - Kiểm tra Key & Live Sync**: Xem trực tiếp tỷ lệ thiết bị (VD: `5/10 Thiết bị` hoặc `1/1 Thiết bị`), tự động cập nhật khi khách nhập. Khi cán mốc `10/10` lượt nhập sẽ tự động khóa. Kèm nút Test Kích hoạt để thử nghiệm nhảy số thiết bị ngay trên máy.
3. **`Info.plist`**: Cấu hình thông tin ứng dụng iOS (`com.onyxz.keygen`, tên hiển thị `ONYXZ SYSTEM`).
4. **`.github/workflows/build.yml`**: Kịch bản tự động biên dịch bằng máy Mac trên GitHub Actions để xuất ra file `OnyxzKeygen.ipa`.
5. **`zip_project.bat`**: File bấm 1 click là tự động nén toàn bộ thư mục thành `OnyxzKeygen_IPA_Project.zip`.

---

## 🚀 Các bước lấy file `.ipa` từ GitHub Actions (Miễn phí 100% không cần máy Mac):

1. Bạn đã có sẵn file nén **`OnyxzKeygen_IPA_Project.zip`** ở thư mục gốc.
2. Vào [github.com](https://github.com/) $\rightarrow$ Tạo 1 Repository mới (đặt tên ví dụ: `onyxz-keygen-ios`).
3. Tải toàn bộ các file trong thư mục `ios_app` này lên Repo đó (hoặc giải nén zip lên repo).
4. GitHub sẽ tự động nhận diện file `.github/workflows/build.yml` và chạy máy chủ macOS để biên dịch mã nguồn C++ thành file **`OnyxzKeygen.ipa`**.
5. Vào tab **Actions** trên GitHub $\rightarrow$ bấm vào bản build $\rightarrow$ tải file **`OnyxzKeygen-IPA.zip`** về. Giải nén ra sẽ có file **`OnyxzKeygen.ipa`** chuẩn 100%!

---

## 📲 Cài đặt vào iPhone qua ESign / TrollStore:

1. Gửi file `OnyxzKeygen.ipa` sang iPhone (qua Telegram, AirDrop hoặc mở Safari tải về).
2. Mở ứng dụng **ESign** trên iPhone:
   - Vào mục **Tệp (Files)** $\rightarrow$ Bấm nút 3 chấm góc trên $\rightarrow$ **Nhập (Import)** $\rightarrow$ Chọn `OnyxzKeygen.ipa`.
   - Bấm vào app trong danh sách ESign $\rightarrow$ Chọn **Ký (Signature)** $\rightarrow$ Chọn chứng chỉ rồi bấm **Ký**.
   - Bấm **Cài đặt (Install)** $\rightarrow$ Ứng dụng **ONYXZ SYSTEM** sẽ xuất hiện ngay trên màn hình chính iPhone của bạn!
