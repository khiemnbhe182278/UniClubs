package model;

import java.time.LocalDateTime;

public class ClubRegistration {
    private int registrationID;
    private int userID;       // FK -> users(id)
    private int clubID;       // FK -> clubs(clubID)
    private LocalDateTime registrationDate;
    private String status;    // pending, approved, rejected, cancelled
    private String notes;

    // ✅ Thêm clubName để show ra JSP
    private String clubName;

    public ClubRegistration() {
    }

    public ClubRegistration(int registrationID, int userID, int clubID,
                            LocalDateTime registrationDate, String status, String notes, String clubName) {
        this.registrationID = registrationID;
        this.userID = userID;
        this.clubID = clubID;
        this.registrationDate = registrationDate;
        this.status = status;
        this.notes = notes;
        this.clubName = clubName;
    }

    public int getRegistrationID() {
        return registrationID;
    }

    public void setRegistrationID(int registrationID) {
        this.registrationID = registrationID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public LocalDateTime getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(LocalDateTime registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    @Override
    public String toString() {
        return "ClubRegistration{" +
                "registrationID=" + registrationID +
                ", userID=" + userID +
                ", clubID=" + clubID +
                ", registrationDate=" + registrationDate +
                ", status='" + status + '\'' +
                ", notes='" + notes + '\'' +
                ", clubName='" + clubName + '\'' +
                '}';
    }
}
