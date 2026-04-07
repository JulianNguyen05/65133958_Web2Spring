// =============================================
// JAVASCRIPT CHUNG CHO TOÀN BỘ ỨNG DỤNG
// =============================================

document.addEventListener('DOMContentLoaded', function () {

    // 1. Highlight menu active theo URL hiện tại
    const currentPath = window.location.pathname;
    const menuLinks = document.querySelectorAll('.menu a');
    
    menuLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href && currentPath === href) {
            link.classList.add('active');
        }
    });

    // 2. Xác nhận trước khi xóa (Delete)
    const deleteButtons = document.querySelectorAll('.btn-danger');
    deleteButtons.forEach(btn => {
        btn.addEventListener('click', function (e) {
            if (!confirm('Bạn có chắc chắn muốn XÓA mục này không?')) {
                e.preventDefault();
            }
        });
    });

    // 3. Hiển thị thông báo thành công (nếu có param success trong URL)
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('success')) {
        const message = urlParams.get('success') || 'Thao tác thành công!';
        
        const toast = document.createElement('div');
        toast.style.cssText = `
            position: fixed; top: 20px; right: 20px; 
            background: #10b981; color: white; padding: 15px 25px; 
            border-radius: 8px; box-shadow: 0 4px 15px rgba(16,185,129,0.4);
            z-index: 9999; font-weight: 500;
        `;
        toast.textContent = message;
        document.body.appendChild(toast);

        setTimeout(() => {
            toast.style.transition = 'all 0.4s';
            toast.style.opacity = '0';
            setTimeout(() => toast.remove(), 400);
        }, 3000);
    }

    // 4. Tự động ẩn thông báo lỗi sau 5 giây (nếu có)
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        }, 5000);
    });

    console.log('%c🚀 Style & Script đã load thành công!', 'color: #3b82f6; font-weight: bold;');
});