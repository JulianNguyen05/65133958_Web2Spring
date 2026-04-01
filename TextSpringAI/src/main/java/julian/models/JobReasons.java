package julian.models;

import java.util.List;

public record JobReasons(String job, String location, List<String> reasons) {
}