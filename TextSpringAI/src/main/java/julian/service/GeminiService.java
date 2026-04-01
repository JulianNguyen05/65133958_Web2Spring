package julian.service;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Service;

import julian.models.JobReasons;

@Service
public class GeminiService {

	private final ChatClient chatClient;

	public GeminiService(ChatClient.Builder builder) {
		this.chatClient = builder.defaultSystem("Bạn là một chuyên gia nhân sự. Trả về dữ liệu thuần định dạng JSON.")
				.build();
	}

	public JobReasons getJobReasons(int count, String job, String location) {
	    // Chúng ta viết Prompt đơn giản hơn để tránh StringTemplate bị lỗi
	    String promptText = """
	            Hãy đóng vai một chuyên gia nhân sự. 
	            Viết cho tôi {count} lý do tại sao nên làm công việc {job} tại {location}.
	            Yêu cầu kết quả trả về phải khớp hoàn toàn với cấu trúc dữ liệu yêu cầu.
	            """;

	    return chatClient.prompt()
	            .user(u -> u.text(promptText)
	                    .param("count", count)
	                    .param("job", job)
	                    .param("location", location))
	            .call()
	            .entity(JobReasons.class); // Để Spring AI tự lo phần định dạng JSON
	}
}