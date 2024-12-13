package Lecture;

public class LectureDTO {
    private int lectureID;       // 강의 번호
    private String lectureName;  // 강의명
    private String instructor;   // 강사
    private String category;     // 카테고리
    private int students;        // 수강 인원
    private String content;      // 강의 내용

    // 기본 생성자
    public LectureDTO() {}

    // 매개변수가 있는 생성자
    public LectureDTO(int lectureID, String lectureName, String instructor, String category, int students, String content) {
        this.lectureID = lectureID;
        this.lectureName = lectureName;
        this.instructor = instructor;
        this.category = category;
        this.students = students;
        this.content = content;
    }

    // Getter 및 Setter 메서드
    public int getLectureID() {
        return lectureID;
    }

    public void setLectureID(int lectureID) {
        this.lectureID = lectureID;
    }

    public String getLectureName() {
        return lectureName;
    }

    public void setLectureName(String lectureName) {
        this.lectureName = lectureName;
    }

    public String getInstructor() {
        return instructor;
    }

    public void setInstructor(String instructor) {
        this.instructor = instructor;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getStudents() {
        return students;
    }

    public void setStudents(int content) {
        this.students = students;
    }
    
    public String getContent() {
        return content;
    }
    public void setcontent(String content) {
        this.content = content;
    }
}
