package model;

import java.time.LocalDateTime;

public class EventRegistration {
    private int id;
    private int eventId;
    private int userId;
    private LocalDateTime registrationDate;
    private String status;
    private String notes;

    public EventRegistration() {
    }

    public EventRegistration(int id, int eventId, int userId,
                             LocalDateTime registrationDate, String status, String notes) {
        this.id = id;
        this.eventId = eventId;
        this.userId = userId;
        this.registrationDate = registrationDate;
        this.status = status;
        this.notes = notes;
    }

    // Getter & Setter

    @Override
    public String toString() {
        return "EventRegistration{" +
                "id=" + id +
                ", eventId=" + eventId +
                ", userId=" + userId +
                ", status='" + status + '\'' +
                '}';
    }
}
