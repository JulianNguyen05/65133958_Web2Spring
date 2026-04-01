package julian.service;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Service;

import julian.models.JobReasons;

@Service
public class GeminiService {

	private final ChatClient chatClient;

	public GeminiService(ChatClient.Builder builder) {
		this.chatClient = builder
				.defaultSystem("Bạn là một chuyên gia tư vấn nghề nghiệp IT am hiểu thị trường Việt Nam.").build();
	}

	public JobReasons getJobReasons(int count, String job, String location) {
		String promptText = """
				Hãy viết {count} lý do tại sao một người ở {location} nên theo đuổi công việc {job}.
				Các lý do cần ngắn gọn, đi thẳng vào vấn đề.
				""";

		return chatClient.prompt().user(userSpec -> userSpec.text(promptText).param("count", count).param("job", job)
				.param("location", location)).call().entity(JobReasons.class);
	}
}