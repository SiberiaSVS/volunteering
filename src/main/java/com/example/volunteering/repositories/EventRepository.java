package com.example.volunteering.repositories;

import com.example.volunteering.models.Event;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EventRepository extends JpaRepository<Event, Long> {
    List<Event> findByCity(String city);
}
