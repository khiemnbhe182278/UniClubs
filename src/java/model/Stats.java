package model;

public class Stats {

    private int totalClubs;
    private int totalMembers;
    private int totalEvents;
    private double satisfactionRate;

    public Stats() {
    }

    public Stats(int totalClubs, int totalMembers, int totalEvents, double satisfactionRate) {
        this.totalClubs = totalClubs;
        this.totalMembers = totalMembers;
        this.totalEvents = totalEvents;
        this.satisfactionRate = satisfactionRate;
    }

    public int getTotalClubs() {
        return totalClubs;
    }

    public void setTotalClubs(int totalClubs) {
        this.totalClubs = totalClubs;
    }

    public int getTotalMembers() {
        return totalMembers;
    }

    public void setTotalMembers(int totalMembers) {
        this.totalMembers = totalMembers;
    }

    public int getTotalEvents() {
        return totalEvents;
    }

    public void setTotalEvents(int totalEvents) {
        this.totalEvents = totalEvents;
    }

    public double getSatisfactionRate() {
        return satisfactionRate;
    }

    public void setSatisfactionRate(double satisfactionRate) {
        this.satisfactionRate = satisfactionRate;
    }
}
