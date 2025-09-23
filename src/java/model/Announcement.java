package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Announcement {
    private int id;
    private String title;
    private String content;
    private String type;
    private int authorId;
    private String targetAudience;
    private LocalDate publishDate;
    private LocalDate expiryDate;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Announcement() {
    }

    public Announcement(int id, String title, String content, String type, int authorId,
                        String targetAudience, LocalDate publishDate, LocalDate expiryDate,
                        String status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.type = type;
        this.authorId = authorId;
        this.targetAudience = targetAudience;
        this.publishDate = publishDate;
        this.expiryDate = expiryDate;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getter & Setter

    @Override
    public String toString() {
        return "Announcement{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", authorId=" + authorId +
                ", status='" + status + '\'' +
                '}';
    }
}
