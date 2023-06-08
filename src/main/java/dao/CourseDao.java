package dao;

import java.util.List;

import util.DaoHelper;
import vo.Course;
import vo.Dept;
import vo.Professor;

public class CourseDao {
	private static CourseDao instance = new CourseDao();
	private CourseDao() {}
	public static  CourseDao getInstance() {
		return instance;
	}
	public void updateCourse(Course course) {
		DaoHelper.update("courseDao.updateCourse", course.getName(),course.getType(),course.getScore(),course.getQuota(),course.getReqCnt(),course.getDescription(),course.getNo());
	}
	
	public Course getCourseDetailByNo(int courseNo) {
		return DaoHelper.selectOne("courseDao.getCourseDetailByNo", rs ->{
			Course course = new Course();
			course.setNo(rs.getInt("course_no"));
			course.setName(rs.getString("course_name"));
			course.setType(rs.getString("course_type"));
			course.setQuota(rs.getInt("course_quota"));
			course.setReqCnt(rs.getInt("course_req_cnt"));
			course.setScore(rs.getInt("course_score"));
			course.setDescription(rs.getString("course_description"));
			course.setUpdateDate(rs.getDate("course_update_date"));
			course.setCreateDate(rs.getDate("course_create_date"));
			
			Dept dept = new Dept();
			dept.setNo(rs.getInt("dept_no"));
			dept.setName(rs.getString("dept_name"));
			course.setDept(dept);
			
			Professor professor = new Professor();
			professor.setId(rs.getString("professor_id"));
			professor.setName(rs.getString("professor_name"));
			course.setProfessor(professor);
			return course;
		}, courseNo);
	}
	public int getTotalRows() {
		return DaoHelper.selectOne("courseDao.getTotalRows", rs -> {
			return rs.getInt("cnt");
		});
	}	

	public List<Course> getAllCourses() {
		return DaoHelper.selectList("courseDao.getAllCourses", rs ->{
			Course course = new Course();
			course.setNo(rs.getInt("course_no"));
			course.setName(rs.getString("course_name"));
			course.setQuota(rs.getInt("course_quota"));
			course.setReqCnt(rs.getInt("course_req_cnt"));
			
			Dept dept = new Dept();
			dept.setNo(rs.getInt("dept_no"));
			dept.setName(rs.getString("dept_name"));
			course.setDept(dept);
			
			Professor professor = new Professor();
			professor.setId(rs.getString("professor_id"));
			professor.setName(rs.getString("professor_name"));
			course.setProfessor(professor);
			return course;
			
		});
	}
}
