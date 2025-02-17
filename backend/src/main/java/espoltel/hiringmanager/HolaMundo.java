package espoltel.hiringmanager;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HolaMundo {
	@GetMapping("/")
	public String hola() {
		return "Hola mundo";
	}
}
