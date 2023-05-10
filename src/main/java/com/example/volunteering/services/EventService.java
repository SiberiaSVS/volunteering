package com.example.volunteering.services;

import com.example.volunteering.models.Event;
import com.example.volunteering.models.Image;
import com.example.volunteering.models.User;
import com.example.volunteering.repositories.EventRepository;
import com.example.volunteering.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class EventService {
    private final EventRepository eventRepository;
    private final UserRepository userRepository;
    public List<Event> listEvents(String city){
        if(city != null && city != "") return eventRepository.findByCity(city);
        return eventRepository.findAll();
    }

    public void saveEvent(Principal principal, Event event, MultipartFile file1, MultipartFile file2, MultipartFile file3, MultipartFile file4, MultipartFile file5) throws IOException {
        event.setUser(getUserByPrincipal(principal));
        Image image1;
        Image image2;
        Image image3;
        Image image4;
        Image image5;
        if(file1.getSize() != 0) {
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            event.addImageToEvent(image1);
        }
        if(file2.getSize() != 0) {
            image2 = toImageEntity(file2);
            event.addImageToEvent(image2);
        }
        if(file3.getSize() != 0) {
            image3 = toImageEntity(file3);
            event.addImageToEvent(image3);
        }
        if(file4.getSize() != 0) {
            image4 = toImageEntity(file4);
            event.addImageToEvent(image4);
        }
        if(file5.getSize() != 0) {
            image5 = toImageEntity(file5);
            event.addImageToEvent(image5);
        }
        log.info("Saving new event with id {}", event.getId());
        Event eventFromDb = eventRepository.save(event);
        eventFromDb.setPreviewImageId(eventFromDb.getImages().get(0).getId());
        eventRepository.save(event);
    }

    public User getUserByPrincipal(Principal principal) {
        if(principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    public void deleteEvent(Long id) {
        eventRepository.deleteById(id);
    }

    public Event getEventById(Long id) {
        return eventRepository.findById(id).orElse(null);
    }
}
