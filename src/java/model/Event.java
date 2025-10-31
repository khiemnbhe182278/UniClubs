package model;

import java.sql.Timestamp;

public class Event {

    private int eventID;
    private int clubID;
    private String eventName;
    private String description;
    private Timestamp eventDate;
    private String status;
    private Timestamp createdAt;
    private String clubName;
    private String location;
    private int maxParticipants;
    private int currentParticipants;
    private Timestamp registrationDeadline;  // NEW FIELD
    private String eventImage;                // NEW FIELD

    public Event() {
    }

    // Getters and Setters
    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getEventDate() {
        return eventDate;
    }

    public void setEventDate(Timestamp eventDate) {
        this.eventDate = eventDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getMaxParticipants() {
        return maxParticipants;
    }

    public void setMaxParticipants(int maxParticipants) {
        this.maxParticipants = maxParticipants;
    }

    public int getCurrentParticipants() {
        return currentParticipants;
    }

    public void setCurrentParticipants(int currentParticipants) {
        this.currentParticipants = currentParticipants;
    }

    // NEW GETTERS AND SETTERS
    public Timestamp getRegistrationDeadline() {
        return registrationDeadline;
    }

    public void setRegistrationDeadline(Timestamp registrationDeadline) {
        this.registrationDeadline = registrationDeadline;
    }

    public String getEventImage() {
        return eventImage;
    }

    public void setEventImage(String eventImage) {
        this.eventImage = eventImage;
    }

    // HELPER METHODS
    /**
     * Check if registration is still open
     *
     * @return true if registration deadline hasn't passed
     */
    public boolean isRegistrationOpen() {
        if (registrationDeadline == null) {
            return true; // No deadline means always open
        }
        return new Timestamp(System.currentTimeMillis()).before(registrationDeadline);
    }

    /**
     * Check if event is full
     *
     * @return true if max participants reached
     */
    public boolean isFull() {
        if (maxParticipants <= 0) {
            return false; // No limit
        }
        return currentParticipants >= maxParticipants;
    }

    /**
     * Get available slots
     *
     * @return number of slots remaining, or -1 if unlimited
     */
    public int getAvailableSlots() {
        if (maxParticipants <= 0) {
            return -1; // Unlimited
        }
        return maxParticipants - currentParticipants;
    }

    /**
     * Check if user can register
     *
     * @return true if registration is open and event is not full
     */
    public boolean canRegister() {
        return isRegistrationOpen() && !isFull() && "Approved".equals(status);
    }
}
