'''
    IP段匹配
'''
import ipaddress as ipaddr
import pandas as pd


def makecidr(DATAframe):
    cidr=pd.DataFrame()
    for i in range(DATAframe.shape[0]):
        if ":" in DATAframe.loc[i,"start_ip"]:
            start_ip=ipaddr.ip_address(DATAframe.loc[i,"start_ip"])
            end_ip=ipaddr.ip_address(DATAframe.loc[i,"end_ip"])
            ipcidr=ipaddr.summarize_address_range(start_ip,end_ip)
            for ips in ipcidr:
                cidr = cidr.append([[ips]])

    return cidr
def matchIP(ip,cidrs):
    for c in cidrs.keys():
        for j in range(cidrs[c].shape[0]):
            if (ipaddr.IPv6Address(ip) in ipaddr.IPv6Network(cidrs[c].iloc[j, 0])):

                return str(c)
if __name__=="__main__":
    # 读取原始数据
    cidrs=[]
    dx = pd.read_excel("./res_data/IPrange/山东电信.xlsx", names=["time", "start_ip", "end_ip", "organization", "company"])
    yd = pd.read_excel("./res_data/IPrange/山东移动.xlsx", names=["time", "start_ip", "end_ip", "organization", "company"])
    lt = pd.read_excel("./res_data/IPrange/山东联通.xlsx", names=["time", "start_ip", "end_ip", "organization", "company"])
    ips=pd.read_csv("./result/v6/allv6dns.csv",header=0)

    # dx_cidr=makecidr(dx)
    # yd_cidr=makecidr(yd)
    # lt_cidr=makecidr(lt)
    cidrs={"dx":makecidr(dx),"yd":makecidr(yd),"lt":makecidr(lt)}
    ips["company"]=ips["IPv6"].map(lambda x:matchIP(x,cidrs))
    ips_n=pd.pivot_table(ips,values=["Count"],index=["IPv6"],aggfunc=sum)
    ips_c=ips.drop_duplicates(subset=["IPv6"],keep="first")
    ips_L=ips_n.merge(ips_c.loc[:,["IPv6","company"]],how="left",on="IPv6")
    ips_L.to_csv("./result/v6/v6DNSs.csv",index=False)
    # for i in range(ips.shape[0]):


