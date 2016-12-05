use strict;
use warnings;
use Net::Microsoft::CognitiveServices::Face;
use Guard 'guard';

### 長い名前のモジュールなので、簡単に呼べるように変数に代入
my $api = 'Net::Microsoft::CognitiveServices::Face';

### アクセスキーの登録
$api->access_key($ARGV[0]);

### 有名人の元データ
my %image = (
    'Yo Ooizumi'        => 'http://s3-ap-northeast-1.amazonaws.com/topicks/article_thumb/15584_original.jpg',
    'Takayuki Suzui'    => 'https://www.office-cue.com/image/portrait/xl_talent01.jpg',
    'Ken Yasuda'        => 'http://yononakanews.com/wp-content/uploads/2014/10/3658-1.jpg',
    'Takuma Otoo'       => 'http://image.pia.jp/images/news/img/ORG_20111128001518.jpg',
    'Hiroyuki Morisaki' => 'http://www.suruga-ya.jp/database/pics/game/g6235130.jpg',
);

### PersonGroup IDの定義
my $person_group_id = 'dummy';

### すべての処理が終わったら PersonGroupごと削除する
my $guard = guard {
    $api->PersonGroup->delete($person_group_id)
};

### PersonGroupの作成
$api->PersonGroup->create($person_group_id, name => 'Super Star');

### 有名人を認識させる
for my $name (keys %image) {
    sleep 1; ## Request Rate Limit に引っかからないように頑張る
    my $person = $api->Person->create($person_group_id, name => $name);
    $api->Person->add_face($person_group_id, $person->{personId}, $image{$name});
}

### PersonGroupに学習をさせる
$api->PersonGroup->train($person_group_id);

### 学習が終わるのを待つ。
for (1 .. 12) {
    sleep 5;
    my $status = $api->PersonGroup->training_status($person_group_id);
    last if $status->{status} eq "succeeded";
}

### 大泉洋の顔画像（元データとは別のデータ）を食わせて、faceIdを取得する
my $face = $api->Face->detect('http://www.officiallyjd.com/wp-content/uploads/2012/02/20120227_akb_13.jpg');

### 取得できたfaceIdを元に、顔画像マッチングを行う。
my $ident = $api->Face->identify(
    faceIds                    => [ $face->[0]{faceId} ],
    personGroupId              => $person_group_id,
    maxNumOfCandidatesReturned => 1,
    confidenceThreshold        => 0.5,
);

### faceIdにマッチした顔画像中から、personIdを含むObjectを引っ張ってくる
my $candidate = $ident->[0]{candidates}[0];

### personIdを元にpersonデータを取得する
my $hit = $api->Person->get($person_group_id, $candidate->{personId});

### personデータを吐き出す
use Data::Dumper;
warn Dumper($hit);
