package Object;


public class SimpleUser {
    String firstName;
    String lastName;
    String headline;

    public SimpleUser(String firstName, String lastName, String headline) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.headline = headline;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getHeadline() {
        return headline;
    }

    public void setHeadline(String headline) {
        this.headline = headline;
    }

    @Override
    public String toString() {
        return "SimpleUser{" + "firstName=" + firstName + ", lastName=" + lastName + ", headline=" + headline + '}';
    }
    
}
