package model;

import java.sql.Timestamp;

public class Club {

    private int clubID;
    private String clubName;
    private String description;
    private String logo;
    private int facultyID;
    private int leaderID;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private int memberCount;
    private String categoryName;

    // Constructors
    public Club() {
    }

    public Club(int clubID, String clubName, String description, String logo,
            int memberCount, String categoryName) {
        this.clubID = clubID;
        this.clubName = clubName;
        this.description = description;
        this.logo = logo;
        this.memberCount = memberCount;
        this.categoryName = categoryName;
    }

    // Getters and Setters
    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public int getMemberCount() {
        return memberCount;
    }

    public void setMemberCount(int memberCount) {
        this.memberCount = memberCount;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
