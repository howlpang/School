package dao;

import java.util.List;

import util.DaoHelper;
import vo.Dept;

public class DeptDao {

	private static DeptDao instance = new DeptDao();
	private DeptDao() {}
	public static DeptDao getInstance() {
		return instance;
	}
	
	public List<Dept> getAllDepts() {
		return DaoHelper.selectList("deptDao.getAllDepts", rs -> {
			Dept dept = new Dept();
			dept.setNo(rs.getInt("dept_no"));
			dept.setName(rs.getString("dept_name"));
			
			return dept;
			
		});
	}
}
