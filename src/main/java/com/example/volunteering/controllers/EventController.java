package com.example.volunteering.controllers;

import com.example.volunteering.models.Event;
import com.example.volunteering.models.User;
import com.example.volunteering.services.EventService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class EventController {
    private final EventService eventService;
    @GetMapping("/events")
    public String events(@RequestParam(name = "city", required = false) String city, Principal principal, Model model) {
        model.addAttribute("events", eventService.listEvents(city));
        model.addAttribute("user", eventService.getUserByPrincipal(principal));
        return "events";
    }

    @GetMapping("/event/{id}")
    public String eventInfo(@PathVariable Long id, Model model, Principal principal) {
        Event event = eventService.getEventById(id);
        model.addAttribute("event", event);
        model.addAttribute("images", event.getImages());
        model.addAttribute("user", eventService.getUserByPrincipal(principal));
        return "event-info";
    }

    @PostMapping("/event/create")
    public String createEvent(@RequestParam(value = "file1", required = false) MultipartFile file1,
                              @RequestParam(value = "file2", required = false) MultipartFile file2,
                              @RequestParam(value = "file3", required = false) MultipartFile file3,
                              @RequestParam(value = "file4", required = false) MultipartFile file4,
                              @RequestParam(value = "file5", required = false) MultipartFile file5,
                              Event event, Principal principal) throws IOException {
        eventService.saveEvent(principal, event, file1, file2, file3, file4, file5);
        return "redirect:/profile";
    }

    @GetMapping("/event/create")
    public String createEvent(Principal principal, Model model) {
        model.addAttribute("user", eventService.getUserByPrincipal(principal));
        return "create-event";
    }

    @PostMapping("/event/delete/{id}")
    public String deleteEvent(@PathVariable Long id) {
        eventService.deleteEvent(id);
        return "redirect:/profile";
    }
}
