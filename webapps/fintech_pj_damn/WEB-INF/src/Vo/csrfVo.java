package fintech_pj_damn;

import java.util.UUID;

public class csrfVo {
    private UUID sUuid;

    public csrfVo(){
        this.sUuid = UUID.randomUUID();
    }
	
	public String getUuid() {
		return sUuid.toString();
	}
}
