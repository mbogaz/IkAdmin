package Object;

import java.util.ArrayList;


public class Advert {
    int code;
    String header;
    String definition;
    String requirements;
    String activationTime;
    String closeTime;
    boolean active;
    
    public void setActive(boolean active){
        this.active = active;
    }
    
    public boolean isActive(){
        return active;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public String getDefinition() {
        return definition;
    }

    public void setDefinition(String definition) {
        this.definition = definition;
    }

    public String getRequirements() {
        return requirements;
    }

    public void setRequirements(String requirements) {
        this.requirements = requirements;
    }

    public String getActivationTime() {
        return activationTime;
    }

    public void setActivationTime(String activationTime) {
        this.activationTime = activationTime;
    }

    public String getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(String closeTime) {
        this.closeTime = closeTime;
    }

    public Advert(int code, String header, String definition, String activationTime, String closeTime) {
        this.code = code;
        this.header = header;
        this.definition = definition;
        this.activationTime = activationTime;
        this.closeTime = closeTime;
    }

    public Advert(int code, String header, String definition, String requirements, String activationTime, String closeTime) {
        this.code = code;
        this.header = header;
        this.definition = definition;
        this.requirements = requirements;
        this.activationTime = activationTime;
        this.closeTime = closeTime;
    }
    
}
