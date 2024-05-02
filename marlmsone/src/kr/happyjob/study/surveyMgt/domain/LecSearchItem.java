package kr.happyjob.study.surveyMgt.domain;
import static java.lang.Math.*;
import org.springframework.web.util.UriComponentsBuilder;

public class LecSearchItem {
    public static final int DEFAULT_PAGE_SIZE = 5;
    public static final int MIN_PAGE_SIZE = 1;
    public static final int MAX_PAGE_SIZE = 100;

    private Integer page = 1;
    private Integer pageSize = DEFAULT_PAGE_SIZE;

    public LecSearchItem() {}

    public LecSearchItem(Integer page, Integer pageSize, Integer user_no) {
        this.page = page;
        this.pageSize = pageSize;
    }

    public LecSearchItem(Integer page, Integer pageSize) {
        this(page, pageSize, 0);
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = (pageSize != null) ? pageSize : DEFAULT_PAGE_SIZE;
        this.pageSize = Math.max(MIN_PAGE_SIZE, Math.min(this.pageSize, MAX_PAGE_SIZE));
    }

    public String getQueryString() {
        return getQueryString(page);
    }

    public String getQueryString(Integer page) {
        return UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .build().toString();
    }

    public Integer getOffset() {
        int result = (page - 1) * pageSize;
        return Math.max(result, 0);
    }
}