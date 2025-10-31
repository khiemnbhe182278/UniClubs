package model;

import java.sql.Timestamp;
import java.io.Serializable;

public class Rule implements Serializable {

    private static final long serialVersionUID = 1L;

    private int ruleID;
    private int clubID;
    private String title;
    private String ruleText;
    private Timestamp createdDate;

    public Rule() {
    }

    public Rule(int ruleID, int clubID, String title, String ruleText) {
        this.ruleID = ruleID;
        this.clubID = clubID;
        this.title = title;
        this.ruleText = ruleText;
    }

    public Rule(int clubID, String title, String ruleText) {
        this.clubID = clubID;
        this.title = title;
        this.ruleText = ruleText;
    }

    // Getters and Setters
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getRuleText() {
        return ruleText;
    }

    public void setRuleText(String ruleText) {
        this.ruleText = ruleText;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

}
