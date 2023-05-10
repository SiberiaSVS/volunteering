package com.example.volunteering.services;

import com.example.volunteering.models.User;
import com.example.volunteering.models.enums.Role;
import com.example.volunteering.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public boolean createUser(User user) {
        String email = user.getEmail();
        if(userRepository.findByEmail(email) != null) return false;
        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        if(userRepository.findAll().isEmpty()) {
            user.getRoles().add(Role.ROLE_ADMIN);
        }
        else {
            user.getRoles().add(Role.ROLE_USER);
        }
        log.info("Saving new user with email: {}", email);
        userRepository.save(user);
        return true;
    }

    public List<User> list() {
        return userRepository.findAll();
    }

    public void banUser(Long id) {
        if (id != 1) {
            User user = userRepository.findById(id).orElse(null);
            if (user != null) {
                if (user.isActive()) {
                    user.setActive(false);
                    log.info("user with id {} banned", user.getId());
                } else {
                    user.setActive(true);
                    log.info("user with id {} unbanned", user.getId());
                }
            }
            userRepository.save(user);
        }
    }

    public void changeUserRoles(User user, Map<String, String> form) {
        if (user.getId() != 1) {
            Set<String> roles = Arrays.stream(Role.values())
                    .map(Role::name)
                    .collect(Collectors.toSet());
            user.getRoles().clear();
            for (String key : form.keySet()) {
                if (roles.contains(key)) {
                    user.getRoles().add(Role.valueOf(key));
                }
            }
            userRepository.save(user);
        }
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    public void deleteUserById(Long id) {
        if (id != 1) {
            userRepository.deleteById(id);
        }
    }

    public boolean updateUser(User user) {
        String email = user.getEmail();
        if(userRepository.findByEmail(email) != null) return false;
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        return true;
    }
}
