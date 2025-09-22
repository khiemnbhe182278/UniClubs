package model;

public class UserDTO {

    private int userID;
    private String userName;
    private String email;
    private String passwordHash;
    private int roleID;
    private String role;
    private String managedClub;
    private String joinedClubs;
    private boolean status; 

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getManagedClub() {
        return managedClub;
    }

    public void setManagedClub(String managedClub) {
        this.managedClub = managedClub;
    }

    public String getJoinedClubs() {
        return joinedClubs;
    }

    public void setJoinedClubs(String joinedClubs) {
        this.joinedClubs = joinedClubs;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
