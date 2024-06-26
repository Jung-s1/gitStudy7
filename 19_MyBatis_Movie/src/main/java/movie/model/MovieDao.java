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

	// 검색조회
	public int getTotalCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		return cnt;
	}// getTotalCount

	// 목록조회, 검색, 페이지 설정
	public List<MovieBean> getMovieList(Map<String, String> map, Paging pageInfo) {
		System.out.println("getTravelList");
		System.out.println(pageInfo.getLimit());
		System.out.println(pageInfo.getOffset());

		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());

		List<MovieBean> lists = new ArrayList<MovieBean>();
		lists = sqlSessionTemplate.selectList(namespace + ".getMovieList", map, rowBounds);

		System.out.println("Movie 사이즈 : " + lists.size());

		return lists;
	}// getMovieList

	// 영화 정보 삽입
	public int insertMovie(MovieBean movie) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".insertMovie", movie); // insert 쿼리 실행
		System.out.println("insertMovie cnt: " + cnt);
		return cnt;
	}

	// 삭제
	public int deleteMovie(int num) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".deleteMovie", num);
		System.out.println("deleteTravel cnt : " + cnt);
		return cnt;
	}// deleteMovie

	// 업뎃
	public int updateMovie(MovieBean movie) {

		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".updateMovie", movie);
		return cnt;

	}// updateMovie

	// 번호로 조회하여 영화 정보 가져오기
	public MovieBean getMovieByNum(int num) {
		MovieBean movie = null;
		movie = sqlSessionTemplate.selectOne(namespace + ".getMovieByNum", num);
		return movie;
	}// getMovieByNum

	// 중복체크
	public int searchTitle(String inputtitle) {
		int count = -1;
		count = sqlSessionTemplate.selectOne(namespace + ".searchTitle", inputtitle);
		return count;
	}// searchTitle

	// 영화제목 상세보기
	public MovieBean detailMovie(int num) {
		MovieBean mb = null;
		mb = sqlSessionTemplate.selectOne(namespace + ".detailMovie", num);

		return mb;
	}// detailMovie
}
