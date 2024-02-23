#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <algorithm>
using namespace std;

const int maxn=60;
const int maxchar=maxn*8*3;

struct ds
{
    int n;
    int a[maxn*3];

    ds(int _n=0):n(_n){}

    void read()
    {
        char st[maxchar];
        scanf("%s", st);
        int len=strlen(st);
        for (int i=len-1; i>=0; i-=8)
        {
            int num=0;
            for (int j=max(0, i-8+1); j<=i; ++j) num=num<<1|(st[j]-'0');
            a[n++]=num;
        }
    }

    ds operator * (ds &other)
    {
        ds ans;
        ans.n=n+other.n-1;
        for (int i=0; i<=ans.n; ++i) ans.a[i]=0;
        for (int i=0; i<n; ++i)
            for (int j=0; j<other.n; ++j)
                ans.a[i+j]+=a[i]*other.a[j];
        for (int i=0; i<ans.n; ++i)
        {
            ans.a[i+1]+=ans.a[i]>>8;
            ans.a[i]&=0xff;
        }
        if (ans.a[ans.n]>0) ans.n++;
        return ans;
    }

    bool operator < (ds other)
    {
        if (n!=other.n) return n<other.n;
        for (int i=n-1; i>=0; --i)
            if (a[i]!=other.a[i]) return a[i]<other.a[i];
        return false;
    }
};

ds cipher, m;

int main()
{
    cipher.read();
    m.n=50;
    for (int i=m.n-1; i>=0; --i)
    {
        // printf("%d\n", i);
        for (int j=7; j>=0; --j)
        {
            m.a[i]|=1<<j;
            if (cipher<m*m*m) m.a[i]^=1<<j;
        }
        if (m.n-1==i && m.a[i]==0) m.n--;
    }
    for (int i=m.n-1; i>=0; --i) printf("%c", m.a[i]);
    printf("\n");
    return 0;
}