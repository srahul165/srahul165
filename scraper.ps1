import requests
from bs4 import BeautifulSoup
import json
import time
import csv
from csv import writer


class Zillow():
    results = []
    #### Replace from your selected zillow page. LOOK FOR THESE SPECIFIC LINES
    headers = {
        'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
        'accept-encoding': 'gzip, deflate, br',
        'accept-language': 'en-US,en;q=0.9',
        'cache-control': 'max-age=0',
        'cookie': 'zguid=23|%24e4b7d6e9-71a8-4b0a-9767-d6133eb067b3; zgsession=1|1c0342cd-2935-4e31-8171-1a6b132cf09c; _ga=GA1.2.105018739.1636663442; _gid=GA1.2.1573451619.1636663442; _pxvid=1a66da9c-4330-11ec-87ec-61466f7a574a; zjs_user_id=null; zjs_anonymous_id=%22e4b7d6e9-71a8-4b0a-9767-d6133eb067b3%22; _gcl_au=1.1.347384188.1636663443; KruxPixel=true; DoubleClickSession=true; __pdst=6b76d8c6761d4676b30a840e226ea81d; _fbp=fb.1.1636663443233.707538335; _pin_unauth=dWlkPU5EWXlOams0WWpFdE56TmpOUzAwTlRFM0xUbG1ZekV0TkRFd1pETTJOVEUyWVRsbA; JSESSIONID=B6C557FE2754820C6DD9265301DAF870; utag_main=v_id:017d10be3e54001f6125b395c55905072001706a00bd0$_sn:1$_se:1$_ss:1$_st:1636665243029$ses_id:1636663443029%3Bexp-session$_pn:1%3Bexp-session$dcsyncran:1%3Bexp-session$tdsyncran:1%3Bexp-session$dc_visit:1$dc_event:1%3Bexp-session$dc_region:us-east-1%3Bexp-session$ttd_uuid:47eb2afc-bba1-4c1f-99bc-200ca54a5288%3Bexp-session; __gads=ID=5103022d20c1f168:T=1636663453:S=ALNI_MaEUq-6SZtU2MINI4rV5gic-Jxrcw; KruxAddition=true; _uetsid=1ade1da0433011ec9ddc2564f1a03392; _uetvid=1ade2b50433011ec9c706f7e27744420; _px3=b4ab1d9a7a8499554433a8133e86738c46db78024993aad4a2b4b7fbdc41188c:en9F/ZyNmcnLe6NXm6U7aLnuRaqRcBX6dhLletTlMPEmdsSlpTM39kX69R5LHG0uEHJwc4xkZ/JpcrUGON+2jQ==:1000:s90n93ts+xxICL5TlQ/ztzWQuNSNNG67JsTNa0HTsortChKIDO2rpKczYaeUKp5duXU2bGDUFp6wAQ4x1iYVuXWJkr2QJt9r3faKT5EZN1JFVDM8JT9yHoXz1VmhKOpoJH7RbwNDWxbPLnpeYEnBQxoBcuv7OFiBqDxAvas55DRK9rjw3PNA2c5+IGsk0nM7e0vxN298hgmikui5cwns6g==; _gat=1; AWSALB=LEVsYt3+5309oM2fwgQYK8KGoUFlOB4fE/XVOLkC73VspkrESDFXfuZXvgOrXmjjBPzBT98CsPTkX+r9fgHJCm0NI0J+OW+JAfuDBLpyLa0VUkgoaOP2SuUh80nq; AWSALBCORS=LEVsYt3+5309oM2fwgQYK8KGoUFlOB4fE/XVOLkC73VspkrESDFXfuZXvgOrXmjjBPzBT98CsPTkX+r9fgHJCm0NI0J+OW+JAfuDBLpyLa0VUkgoaOP2SuUh80nq; search=6|1639255991868%7Crect%3D39.3661918428691%252C-76.94861599804688%252C38.9220601465365%252C-77.46772000195313%26rid%3D2975%26disp%3Dmap%26mdm%3Dauto%26p%3D1%26z%3D1%26baths%3D2.0-%26beds%3D4-%26type%3Dhouse%26price%3D0-600000%26mp%3D0-1990%26fs%3D1%26fr%3D0%26mmm%3D0%26rs%3D0%26ah%3D0%26singlestory%3D0%26housing-connector%3D0%26abo%3D0%26garage%3D0%26pool%3D0%26ac%3D0%26waterfront%3D0%26finished%3D0%26unfinished%3D0%26cityview%3D0%26mountainview%3D0%26parkview%3D0%26waterview%3D0%26hoadata%3D1%26zillow-owned%3D0%263dhome%3D0%26featuredMultiFamilyBuilding%3D0%26excludeNullAvailabilityDates%3D0%09%092975%09%09%09%09%09%09',
        'sec-fetch-dest': 'document',
        'sec-fetch-mode': 'navigate',
        'sec-fetch-site': 'same-origin',
        'sec-fetch-user': '?1',
        'upgrade-insecure-requests': '1',
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36'
    }

    def fetch(self, url, params):
        response = requests.get(url, headers=self.headers, params=params)
        print(response.status_code)
        return response

    def parse(self, response):
        content = BeautifulSoup(response, 'lxml')
        deck = content.find('ul',{'class': 'photo-cards photo-cards_wow photo-cards_short photo-cards_extra-attribution'})
        for card in deck.contents:
            script = card.find('script', {'type': 'application/ld+json' })
            if script:
                script_json = json.loads(script.contents[0])

                self.results.append({
                    'latitude': script_json['geo']['latitude'],
                    'longitude': script_json['geo']['longitude'],
                    'floorSize': script_json['floorSize']['value'],
                    'url': script_json['url'],
                    'price': card.find('div', {'class': 'list-card-price'}).text

                })
            
    def to_csv(self):
        with open('zillowdata.csv', 'w+') as csv_file:
            writer = csv.DictWriter(csv_file, fieldnames=self.results[0].keys())
            writer.writeheader()

            for row in self.results:
                writer.writerow(row)
                

#### Replace from your selected zillow page. LOOK FOR THESE SPECIFIC LINES
    def run(self):
        url =  'http://www.zillow.com/montgomery-county-md/houses/'
        ## Put in the page range below
        for page in range(1,4):
                params = {
               'searchQueryState': '{"pagination":{"currentPage": 1},"usersSearchTerm":"Montgomery County, MD","mapBounds":{"west":-77.46772000195313,"east":-76.94861599804688,"south":38.9220601465365,"north":39.3661918428691},"mapZoom":11,"regionSelection":[{"regionId":2975,"regionType":4}],"isMapVisible":false,"filterState":{"beds":{"min":4},"baths":{"min":2},"price":{"max":600000},"mp":{"max":1990},"ah":{"value":true},"sort":{"value":"globalrelevanceex"},"tow":{"value":false},"mf":{"value":false},"con":{"value":false},"apco":{"value":false},"land":{"value":false},"apa":{"value":false},"manu":{"value":false}},"isListVisible":true}' 
            }
                response = self.fetch(url, params)
                self.parse(response.text)
                self.to_csv()


if __name__ == '__main__':
    scraper = Zillow()
    scraper.run()
