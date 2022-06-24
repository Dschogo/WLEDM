// ignore_for_file: file_names

class WLED {
  WLEDState state;
  WLEDInfo info;
  WLEDEffectPalette effectPalette;

  WLED({
    required this.state,
    required this.info,
    required this.effectPalette,
  });

  factory WLED.fromJson(Map<String, dynamic> json) {
    return WLED(
      state: WLEDState.fromJson(json),
      info: WLEDInfo.fromJson(json),
      effectPalette: WLEDEffectPalette.fromJson(json),
    );
  }

  WLED update(Map<String, dynamic> json) {
    state = WLEDState.fromJson(json);
    info = WLEDInfo.fromJson(json);

    return this;
  }

  @override
  String toString() {
    return 'WLED{state: $state, info: $info, effectPalette: $effectPalette}';
  }

  String stateString() {
    return 'WLED{state: $state}';
  }

  String infoString() {
    return 'WLED{state: $info}';
  }
}

class WLEDState {
  bool on;
  int bri;
  int transition;
  int ps;
  int pl;

  bool nlon;
  int nldur;
  int nlmode;
  int nlbri;
  int nlrem;

  bool udpnsend;
  bool udpnrecv;

  int lor;
  int mainseg;

  dynamic seg;

  WLEDState({
    required this.on,
    required this.bri,
    required this.transition,
    required this.ps,
    required this.pl,
    required this.nlon,
    required this.nldur,
    required this.nlmode,
    required this.nlbri,
    required this.nlrem,
    required this.udpnsend,
    required this.udpnrecv,
    required this.lor,
    required this.mainseg,
    required this.seg,
  });

  factory WLEDState.fromJson(Map<String, dynamic> json) {
    json = json['state'];
    return WLEDState(
      on: json['on'],
      bri: json['bri'],
      transition: json['transition'],
      ps: json['ps'],
      pl: json['pl'],
      nlon: json['nl']['on'],
      nldur: json['nl']['dur'],
      nlmode: json['nl']['mode'],
      nlbri: json['nl']['tbri'],
      nlrem: json['nl']['rem'],
      udpnsend: json['udpn']['send'],
      udpnrecv: json['udpn']['recv'],
      lor: json['lor'],
      mainseg: json['mainseg'],
      seg: json['seg'],
    );
  }

  @override
  String toString() {
    return 'WLEDState{on: $on, bri: $bri, transition: $transition, ps: $ps, pl: $pl, nlon: $nlon, nldur: $nldur, nlmode: $nlmode, nlbri: $nlbri, nlrem: $nlrem, udpnsend: $udpnsend, udpnrecv: $udpnrecv, lor: $lor, mainseg: $mainseg, seg: $seg}';
  }

  toJson() {
    return {
      'on': on,
      'bri': bri,
      'transition': transition,
      'ps': ps,
      'pl': pl,
      'nl': {
        'on': nlon,
        'dur': nldur,
        'mode': nlmode,
        'tbri': nlbri,
        'rem': nlrem,
      },
      'udpn': {
        'send': udpnsend,
        'recv': udpnrecv,
      },
      'lor': lor,
      'mainseg': mainseg,
      'seg': seg,
    };
  }
}

class WLEDInfo {
  String ver;
  int vid;
  dynamic leds;
  bool str;
  String name;
  int udpport;
  bool live;
  String lm;
  String lip;
  int ws;
  int fxcount;
  int palcount;
  dynamic wifi;
  dynamic fs;
  int ndc;
  String arch;
  String core;
  int lwip;
  int freeheap;
  int uptime;
  int opt;
  String brand;
  String product;
  String mac;
  String ip;

  WLEDInfo({
    required this.ver,
    required this.vid,
    required this.leds,
    required this.str,
    required this.name,
    required this.udpport,
    required this.live,
    required this.lm,
    required this.lip,
    required this.ws,
    required this.fxcount,
    required this.palcount,
    required this.wifi,
    required this.fs,
    required this.ndc,
    required this.arch,
    required this.core,
    required this.lwip,
    required this.freeheap,
    required this.uptime,
    required this.opt,
    required this.brand,
    required this.product,
    required this.mac,
    required this.ip,
  });

  factory WLEDInfo.fromJson(Map<String, dynamic> json) {
    json = json['info'];
    return WLEDInfo(
      ver: json['ver'],
      vid: json['vid'],
      leds: json['leds'],
      str: json['str'],
      name: json['name'],
      udpport: json['udpport'],
      live: json['live'],
      lm: json['lm'],
      lip: json['lip'],
      ws: json['ws'],
      fxcount: json['fxcount'],
      palcount: json['palcount'],
      wifi: json['wifi'],
      fs: json['fs'],
      ndc: json['ndc'],
      arch: json['arch'],
      core: json['core'],
      lwip: json['lwip'],
      freeheap: json['freeheap'],
      uptime: json['uptime'],
      opt: json['opt'],
      brand: json['brand'],
      product: json['product'],
      mac: json['mac'],
      ip: json['ip'],
    );
  }

  @override
  String toString() {
    return 'WLEDInfo{ver: $ver, vid: $vid, leds: $leds, str: $str, name: $name, udpport: $udpport, live: $live, lm: $lm, lip: $lip, ws: $ws, fxcount: $fxcount, palcount: $palcount, wifi: $wifi, fs: $fs, ndc: $ndc, arch: $arch, core: $core, lwip: $lwip, freeheap: $freeheap, uptime: $uptime, opt: $opt, brand: $brand, product: $product, mac: $mac, ip: $ip}';
  }
}

class WLEDEffectPalette {
  List<dynamic> effects;
  List<dynamic> palettes;

  WLEDEffectPalette({
    required this.effects,
    required this.palettes,
  });

  factory WLEDEffectPalette.fromJson(Map<String, dynamic> json) {
    List e =
        List.generate(json['effects'].length - 1, (index) => index * index);
    for (var i = 0; i < json['effects'].length - 1; i++) {
      e[i] = [json['effects'][i + 1], i + 1];
    }
    e.sort((a, b) => a[0].compareTo(b[0]));

    List p =
        List.generate(json['palettes'].length - 1, (index) => index * index);
    for (var i = 0; i < json['palettes'].length - 1; i++) {
      p[i] = [json['palettes'][i + 1], i + 1];
    }
    p.sort((a, b) => a[0].compareTo(b[0]));
    return WLEDEffectPalette(
      effects: e,
      palettes: p,
    );
  }

  @override
  String toString() {
    return 'WLEDEffectPalette{effects: $effects, palettes: $palettes}';
  }
}
