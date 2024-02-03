// وارد کردن کتابخانه‌های مورد نیاز
const http = require('http');
const socketio = require('socket.io');

// ساختن یک سرور HTTP
const server = http.createServer((req, res) => {
  res.end('Hello World!');
});

// ایجاد یک سرور وب سوکت با استفاده از Socket.IO
const io = socketio(server);

// تعریف یک رویداد برای اتصال کلاینت‌ها
io.on('connection', (socket) => {
  // ارسال یک پیام خوش‌آمدگویی به کلاینت
  socket.emit('message', 'Welcome to WebSocket Test Server!');

  // دریافت هر پیامی که از کلاینت ارسال می‌شود
  socket.on('message', (msg) => {
    // نمایش پیام دریافتی در کنسول
    console.log('Received message from client: ' + msg);
  });
});

// شروع گوش دادن به پورت 3000
server.listen(3000, () => {
  console.log('Server is listening on port 3000');
});
