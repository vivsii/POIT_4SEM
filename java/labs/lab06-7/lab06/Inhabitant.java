public class Inhabitant {
    private int inhabitantId;
    private int cityId;
    private String inhabitantTypeName;
    private String languageSpoken;

    public int getInhabitantId() {
        return inhabitantId;
    }

    public void setInhabitantId(int inhabitantId) {
        this.inhabitantId = inhabitantId;
    }

    public int getCityId() {
        return cityId;
    }

    public void setCityId(int cityId) {
        this.cityId = cityId;
    }

    public String getInhabitantTypeName() {
        return inhabitantTypeName;
    }

    public void setInhabitantTypeName(String inhabitantTypeName) {
        this.inhabitantTypeName = inhabitantTypeName;
    }

    public String getLanguageSpoken() {
        return languageSpoken;
    }

    public void setLanguageSpoken(String languageSpoken) {
        this.languageSpoken = languageSpoken;
    }
}