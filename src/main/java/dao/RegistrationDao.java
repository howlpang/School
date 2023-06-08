package dao;

import java.util.List;

import util.DaoHelper;
import vo.Course;
import vo.Dept;
import vo.Professor;
import vo.Registration;
import vo.Student;

public class RegistrationDao {

   private static RegistrationDao instance = new RegistrationDao();
   private RegistrationDao() {}
   public static RegistrationDao getInstance() {
      return instance;
   }
   
   public void insertRegistration(Registration registration) {
      DaoHelper.update("registrationDao.insertRegistration", 
            registration.getCourse().getNo(), 
            registration.getStudent().getId());
   }
   
   public List<Registration> getRegistrationsByStudentId(String studentId) {
      return DaoHelper.selectList("registrationDao.getRegistrationByStudentId", rs -> {
         Registration reg = new Registration();
         reg.setNo(rs.getInt("reg_no"));
         reg.setStatus(rs.getString("reg_status"));
         
         Course course = new Course();
         course.setNo(rs.getInt("course_no"));
         course.setName(rs.getString("course_name"));
         reg.setCourse(course);
         
         Dept dept = new Dept();
         dept.setNo(rs.getInt("dept_no"));
         dept.setName(rs.getString("dept_name"));
         course.setDept(dept);
         
         Professor professor = new Professor();
         professor.setId(rs.getString("professor_id"));
         professor.setName(rs.getString("professor_name"));
         course.setProfessor(professor);         
         
         return reg;
      }, studentId);
   }
   
   public Registration getRegistrationByRegNo(int registrationNo) {
      return DaoHelper.selectOne("registrationDao.getRegistrationByRegNo", rs->{
         Registration reg = new Registration();
         reg.setNo(rs.getInt("reg_no"));
         reg.setStatus(rs.getString("reg_status"));
         reg.setUpdateDate(rs.getDate("reg_update_date"));
         reg.setCreateDate(rs.getDate("reg_create_date"));
         
         Course course = new Course();
         course.setNo(rs.getInt("course_no"));
         reg.setCourse(course);
         
         Student student = new Student();
         student.setId(rs.getString("student_id"));
         reg.setStudent(student);
         
         return reg;
      }, registrationNo);
      
   }
   
   public Registration getRegistrationByCourseAndStudent(int courseNo, String studentId) {
      return DaoHelper.selectOne("registrationDao.getRegistrationByCourseAndStudent", rs->{
         Registration reg = new Registration();
         
         reg.setNo(rs.getInt("reg_no"));
         reg.setStatus(rs.getString("reg_status"));
         reg.setUpdateDate(rs.getDate("reg_update_date"));
         reg.setCreateDate(rs.getDate("reg_create_date"));
         
         Course course = new Course();
         course.setNo(rs.getInt("course_no"));
         reg.setCourse(course);
         
         Student student = new Student();
         student.setId(rs.getString("student_id"));
         reg.setStudent(student);
         
         return reg;
      }, courseNo, studentId);
   }
   
   public void updateRegistration(Registration registration) {
      DaoHelper.update("registrationDao.updateRegistration", 
            registration.getCourse().getNo(),
            registration.getStudent().getId(),
            registration.getStatus(),
            registration.getNo());
   
   }
}