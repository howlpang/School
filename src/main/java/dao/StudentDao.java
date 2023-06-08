package dao;

import util.DaoHelper;
import vo.Dept;
import vo.Student;

public class StudentDao {
	private static StudentDao instance = new StudentDao();
	private StudentDao() {}
	public static StudentDao getInstance() {
		return instance;
	}
	
	public Student getStudentById(String id) {
		return DaoHelper.selectOne("studentDao.getStudentById", rs ->{
			Student student = new Student();
			student.setId(rs.getString("student_id"));
			student.setPassword(rs.getString("student_password"));
			student.setName(rs.getString("student_name"));
			student.setGrade(rs.getInt("student_grade"));
			student.setUpdateDate(rs.getDate("student_update_date"));
			student.setCreateDate(rs.getDate("student_create_date"));
			Dept dept = new Dept();
			dept.setNo(rs.getInt("dept_no"));
			student.setDept(dept);
			return student;
		}, id);
	}
	
	public void insertStudent(Student student) {
		DaoHelper.update("studentDao.insertStudent", student.getId(),student.getPassword(),student.getName(),student.getGrade(),student.getDept().getNo());
	}
}
