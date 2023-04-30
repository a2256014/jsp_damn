package fintech_pj_damn;

public class CommentVo {
	private int commentID;
    private int boardID;
	private String userID;
    private String comment;
	private String commentDate;
	private String isSecret;

	public int getCommentID() {
		return commentID;
	}
	public void setCommentID(int commentID) {
		this.commentID = commentID;
	}
    public int getBoardID() {
		return boardID;
	}
	public void setBoardID(int boardID) {
		this.boardID = boardID;
	}
	public String getuserID() {
		return userID;
	}
	public void setuserID(String userID) {
		this.userID = userID;
	}
    public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}
	public String getisSecret() {
		return isSecret;
	}
	public void setisSecret(String isSecret) {
		this.isSecret = isSecret;
	}
}
