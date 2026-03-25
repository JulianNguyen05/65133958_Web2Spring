package julian.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
// Đã xóa import AntPathRequestMatcher để tránh lỗi

@Configuration
public class SecurityConfig {

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		// Tắt CSRF để cho phép logout bằng URL GET (Gõ thẳng lên trình duyệt)
		http.csrf(csrf -> csrf.disable());

		http.authorizeHttpRequests(auth -> auth.requestMatchers("/public/**").permitAll() // Cho phép không cần login
				.requestMatchers("/products/**", "/products").hasRole("USER") // Cần role USER
				.requestMatchers("/admin/**", "/admin").hasRole("ADMIN") // Cần role ADMIN
				.anyRequest().authenticated() // Các request còn lại cần auth
		).formLogin(form -> form.loginPage("/login") // Tùy chỉnh trang login
				.permitAll() // Cho phép ai cũng xem trang login
				// Xử lý điều hướng dựa trên Role sau khi đăng nhập thành công
				.successHandler((request, response, authentication) -> {
					boolean isAdmin = authentication.getAuthorities().stream()
							.anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
					if (isAdmin) {
						response.sendRedirect("/admin");
					} else {
						response.sendRedirect("/products");
					}
				})).logout(logout -> logout.permitAll().logoutSuccessUrl("/login?logout") // Thành công thì về trang
																							// login kèm thông báo
		);

		return http.build();
	}

	@Bean
	public UserDetailsService userDetailsService() {
		UserDetails user = User.withUsername("user").password("{noop}123") // {noop} để không mã hóa (chỉ demo)
				.roles("USER").build();

		UserDetails admin = User.withUsername("admin").password("{noop}123456").roles("ADMIN", "USER").build();

		return new InMemoryUserDetailsManager(user, admin);
	}
}