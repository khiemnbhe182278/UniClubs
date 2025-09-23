package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Event {
    private int id;
    private String title;
    private String description;
    private LocalDate eventDate;
    private String location;
    private int organizerId;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Event(int aInt, String string, String string1, String string2) {
    }

    public Event(int id, String title, String description, LocalDate eventDate, String location,
                 int organizerId, String status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.eventDate = eventDate;
        this.location = location;
        this.organizerId = organizerId;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getter & Setter

    @Override
    public String toString() {
        return "Event{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", organizerId=" + organizerId +
                ", status='" + status + '\'' +
                '}';
    }
}
