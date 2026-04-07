import java.io.*;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.Arrays;
import java.util.List;

public class Tool {
    public static void main(String[] args) {
        // Thư mục cần quét (mặc định là thư mục hiện tại ".")
        String sourceFolder = "."; 
        // Tên file đầu ra chứa toàn bộ code
        String outputFile = "gop_code.txt";

        // 1. Đuôi file cần lấy (Mình thêm .java, bạn có thể xóa nếu không cần)
        List<String> targetExtensions = Arrays.asList(".css", ".html", ".java");
        
        // 2. Tên file cụ thể cần lấy
        List<String> targetFiles = Arrays.asList("build.gradle", "dockerfile", "docker-compose.yml, application.properties");

        // 3. Các thư mục hệ thống/thư viện KHÔNG NÊN quét để tránh file txt quá nặng
        List<String> ignoreDirs = Arrays.asList(".git", ".idea", ".vscode", "build", "target", "node_modules", "bin");

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {
            Files.walkFileTree(Paths.get(sourceFolder), new SimpleFileVisitor<Path>() {
                
                @Override
                public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) {
                    String dirName = dir.getFileName().toString();
                    // Bỏ qua các thư mục không cần thiết
                    if (ignoreDirs.contains(dirName)) {
                        return FileVisitResult.SKIP_SUBTREE;
                    }
                    return FileVisitResult.CONTINUE;
                }

                @Override
                public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
                    String fileName = file.getFileName().toString().toLowerCase();
                    boolean isMatch = false;

                    // Kiểm tra xem file có đúng đuôi mở rộng không
                    for (String ext : targetExtensions) {
                        if (fileName.endsWith(ext)) {
                            isMatch = true;
                            break;
                        }
                    }

                    // Kiểm tra xem file có đúng tên cụ thể hoặc chứa chữ "docker" không
                    if (!isMatch) {
                        for (String target : targetFiles) {
                            if (fileName.equals(target) || fileName.contains("docker")) {
                                isMatch = true;
                                break;
                            }
                        }
                    }

                    // Tránh gom chính cái file kết quả txt này vào bên trong nó
                    if (fileName.equals(outputFile)) {
                        isMatch = false; 
                    }

                    // Nếu khớp điều kiện, ghi nội dung file đó vào gop_code.txt
                    if (isMatch) {
                        appendFileContent(file, writer);
                    }
                    return FileVisitResult.CONTINUE;
                }
            });
            System.out.println("✅ Đã gom code thành công! Vui lòng kiểm tra file: " + outputFile);
            
        } catch (IOException e) {
            System.out.println("❌ Có lỗi xảy ra: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void appendFileContent(Path file, BufferedWriter writer) throws IOException {
        // Tạo header phân cách giữa các file cho dễ nhìn
        writer.write("================================================================================\n");
        writer.write("FILE: " + file.toString() + "\n");
        writer.write("================================================================================\n");
        
        try {
            // Đọc và ghi từng dòng
            List<String> lines = Files.readAllLines(file);
            for (String line : lines) {
                writer.write(line + "\n");
            }
        } catch (Exception e) {
            writer.write("// Lỗi: Không thể đọc nội dung file này (có thể do sai định dạng text hoặc lỗi encoding).\n");
        }
        writer.write("\n\n"); // Cách ra 2 dòng trước khi nối file tiếp theo
    }
}