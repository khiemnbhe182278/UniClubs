package model;

import java.sql.Timestamp;

public class News {

    private int newsID;
    private int clubID;
    private String title;
    private String content;
    private String status;
    private Timestamp createdAt;

    public News() {
    }

    public News(int newsID, int clubID, String title, String content,
            String status, Timestamp createdAt) {
        this.newsID = newsID;
        this.clubID = clubID;
        this.title = title;
        this.content = content;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getNewsID() {
        return newsID;
    }

    public void setNewsID(int newsID) {
        this.newsID = newsID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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
}
