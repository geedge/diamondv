'''
    DNSv6工具包，注意tomorrow3无法在arm架构处理器上使用（m1）
'''
import dns.resolver
import pandas as pd
import random as rd
import tomorrow3 as tm
from tqdm import tqdm


alphabet = "abcdefghijklmnopqrstuvwxyz1234567890"


result = pd.DataFrame(columns=["rdns", "result"])
dot_ressult = pd.DataFrame(columns=["dot", "result"])



# val负责定位，dataframe指定数据来源
@tm.threads(200)
def dnsresolver(val,dataframe):
    characters = "".join(rd.sample(alphabet, 10))  # 生成子域名
    test = dataframe.loc[val, "rdns"]
    reso = dns.resolver.Resolver()
    reso.nameservers = [test]
    reso.timeout = 10
    try:
        AAAA = reso.resolve(characters + ".v4.testv4-v6.live", "AAAA").response
        # result = result.append([[test, AAAA.rcode()]], ignore_index=True)
        return [test,AAAA.rcode()]
    except:
        # result=result.append([[test, 1]], ignore_index=True)
        return [test,1]



# if __name__=="__main__":
#     mode="main"
#     rdns = pd.read_csv("./res_data/rdns-shandong.csv", names=["rdns"])
#     dot = pd.read_csv("./res_data/853-shandong.csv", names=["dot"])
#     ch_rdns = pd.read_excel("./res_data/全国-递归DNS测量结果.xlsx", names=["rdns", "loc", "company"])
#
#     for i in tqdm(range(ch_rdns.shape[0])):
#         dnsresolver(i,ch_rdns,result)
#
#     if (mode == "rdns"):
#         result.to_csv("./result/"+str(2)+"-ch_rdns.csv")
#     else:
#         dot_ressult.to_csv("./result/dot.csv")


