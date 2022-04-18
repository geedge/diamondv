'''
    探针发送主程序
'''
import pandas as pd
import dnsfound_util as dnsu

alphabet=dnsu.alphabet
#IPv4地址
spath="./res_data/china/forwarder.xlsx"
#返回结果保存
dpath="./result/china/forward/res-5.csv"
ch_dns=pd.read_excel(spath,names=["rdns","loc","company"])
# 对于直接响应dns
# ch_dns=pd.read_excel(spath,names=["rdns","dns"])
# dns_result = pd.DataFrame(columns=["rdns", "result"],)

#保存所有多线程生成器
List=[dnsu.dnsresolver(i,ch_dns) for i in dnsu.tqdm(range(ch_dns.shape[0]))]

#从所有多线程生成器中读取结果
dns_result=pd.concat([pd.DataFrame([res.result()],columns=["rdns","result"]) for res in List],ignore_index=True)

dns_result.to_csv(dpath)
