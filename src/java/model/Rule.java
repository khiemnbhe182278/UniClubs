package model;

import java.util.Date;

public class Rule {

    private int ruleID;
    private int clubID;
    private String ruleText;
    private Date createdAt;
    private String clubName;
    private String title;

    public Rule() {
    }

    public Rule(int ruleID, int clubID, String ruleText, Date createdAt) {
        this.ruleID = ruleID;
        this.clubID = clubID;
        this.ruleText = ruleText;
        this.createdAt = createdAt;
    }

    public int getRuleID() {
        return ruleID;
    }

    public void setRuleID(int ruleID) {
        this.ruleID = ruleID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public String getRuleText() {
        return ruleText;
    }

    public void setRuleText(String ruleText) {
        this.ruleText = ruleText;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }
}
    