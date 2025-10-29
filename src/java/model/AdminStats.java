package model;

public class AdminStats {

    private int pendingClubs;
    private int pendingMembers;
    private int pendingEvents;
    private int totalUsers;

    public AdminStats() {
    }

    public int getPendingClubs() {
        return pendingClubs;
    }

    public void setPendingClubs(int pendingClubs) {
        this.pendingClubs = pendingClubs;
    }

    public int getPendingMembers() {
        return pendingMembers;
    }

    public void setPendingMembers(int pendingMembers) {
        this.pendingMembers = pendingMembers;
    }

    public int getPendingEvents() {
        return pendingEvents;
    }

    public void setPendingEvents(int pendingEvents) {
        this.pendingEvents = pendingEvents;
    }

    public int getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(int totalUsers) {
        this.totalUsers = totalUsers;
    }
}
