package julian.model;

import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Topic {
	private String id;
	private String topicName;
	private String topicDescription;
	private String supervisorId;
	private String topicType;
}