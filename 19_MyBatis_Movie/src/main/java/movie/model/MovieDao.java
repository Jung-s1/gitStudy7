package movie.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("myMovieDao")
public class MovieDao {

	private String namespace = "movie.MovieBean";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public MovieDao() {
		System.out.println("MovieDao()");
	}

	// �˻���ȸ
	public int getTotalCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		return cnt;
	}// getTotalCount

	// �����ȸ, �˻�, ������ ����
	public List<MovieBean> getMovieList(Map<String, String> map, Paging pageInfo) {
		System.out.println("getTravelList");
		System.out.println(pageInfo.getLimit());
		System.out.println(pageInfo.getOffset());

		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());

		List<MovieBean> lists = new ArrayList<MovieBean>();
		lists = sqlSessionTemplate.selectList(namespace + ".getMovieList", map, rowBounds);

		System.out.println("Movie ������ : " + lists.size());

		return lists;
	}// getMovieList

	// ��ȭ ���� ����
	public int insertMovie(MovieBean movie) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".insertMovie", movie); // insert ���� ����
		System.out.println("insertMovie cnt: " + cnt);
		return cnt;
	}

	// ����
	public int deleteMovie(int num) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".deleteMovie", num);
		System.out.println("deleteTravel cnt : " + cnt);
		return cnt;
	}// deleteMovie

	// ����
	public int updateMovie(MovieBean movie) {

		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".updateMovie", movie);
		return cnt;

	}// updateMovie

	// ��ȣ�� ��ȸ�Ͽ� ��ȭ ���� ��������
	public MovieBean getMovieByNum(int num) {
		MovieBean movie = null;
		movie = sqlSessionTemplate.selectOne(namespace + ".getMovieByNum", num);
		return movie;
	}// getMovieByNum

	// �ߺ�üũ
	public int searchTitle(String inputtitle) {
		int count = -1;
		count = sqlSessionTemplate.selectOne(namespace + ".searchTitle", inputtitle);
		return count;
	}// searchTitle

	// ��ȭ���� �󼼺���
	public MovieBean detailMovie(int num) {
		MovieBean mb = null;
		mb = sqlSessionTemplate.selectOne(namespace + ".detailMovie", num);

		return mb;
	}// detailMovie
}
