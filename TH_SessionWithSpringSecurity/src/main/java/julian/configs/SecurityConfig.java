package julian.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http
				// 1. Vô hiệu hóa CSRF tạm thời để tránh lỗi 403 khi test login
				.csrf(csrf -> csrf.disable())

				// 2. Phân quyền truy cập
				.authorizeHttpRequests(auth -> auth
						// Mở cửa hoàn toàn cho các URL này
						.requestMatchers("/login", "/css/**", "/js/**", "/images/**").permitAll()
						// Tất cả các yêu cầu khác phải đăng nhập
						.anyRequest().authenticated())

				// 3. Cấu hình Form Login
				.formLogin(login -> login.loginPage("/login") // URL trả về trang giao diện (GetMapping)
						.loginProcessingUrl("/login") // URL mà Spring sẽ xử lý xác thực (POST)
						.defaultSuccessUrl("/home", true).permitAll())

				// 4. Logout
				.logout(logout -> logout.logoutSuccessUrl("/login?logout").permitAll());

		return http.build();
	}
}