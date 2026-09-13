@echo off
chcp 65001 >nul
echo ========================================================
echo   ĐANG ĐÓNG GÓI DỰ ÁN ONYXZ KEYGEN THÀNH FILE ZIP
echo ========================================================
echo.

cd /d "%~dp0"
set OUTPUT_ZIP=..\OnyxzKeygen_IPA_Project.zip

if exist "%OUTPUT_ZIP%" del "%OUTPUT_ZIP%"

powershell -Command "Compress-Archive -Path '.\*' -DestinationPath '%OUTPUT_ZIP%' -Force"

if exist "%OUTPUT_ZIP%" (
    echo [THÀNH CÔNG] Đã tạo file: OnyxzKeygen_IPA_Project.zip ở thư mục ngoài!
    echo Bạn có thể tải file zip này lên GitHub để nhận file .ipa hoặc gửi sang máy Mac.
) else (
    echo [LỖI] Không thể tạo file zip!
)

echo.
pause
