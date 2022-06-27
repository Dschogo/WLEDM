// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/cupertino.dart';

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

  factory WLEDState.invalid() {
    return WLEDState(
      on: false,
      bri: 0,
      transition: 0,
      ps: 0,
      pl: 0,
      nlon: false,
      nldur: 0,
      nlmode: 0,
      nlbri: 0,
      nlrem: 0,
      udpnsend: false,
      udpnrecv: false,
      lor: 0,
      mainseg: 0,
      seg: null,
    );
  }

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

  factory WLEDInfo.invalid() {
    return WLEDInfo(
      ver: '',
      vid: 0,
      leds: null,
      str: false,
      name: '',
      udpport: 0,
      live: false,
      lm: '',
      lip: '',
      ws: 0,
      fxcount: 0,
      palcount: 0,
      wifi: null,
      fs: null,
      ndc: 0,
      arch: '',
      core: '',
      lwip: 0,
      freeheap: 0,
      uptime: 0,
      opt: 0,
      brand: '',
      product: '',
      mac: '',
      ip: '',
    );
  }

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

  factory WLEDEffectPalette.invalid() {
    return WLEDEffectPalette(
      effects: [],
      palettes: [],
    );
  }

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

  bool isinvalid() {
    return state.seg == null;
  }

  factory WLED.invalid() {
    return WLED(
      state: WLEDState.invalid(),
      info: WLEDInfo.invalid(),
      effectPalette: WLEDEffectPalette.invalid(),
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

  List<Color> getGradient(int id, {int intensity = 255}) {
    switch (id) {
      case 1:
        return [
          Color.fromARGB(intensity, Random().nextInt(intensity),
              Random().nextInt(intensity), Random().nextInt(intensity)),
          Color.fromARGB(intensity, Random().nextInt(intensity),
              Random().nextInt(intensity), Random().nextInt(intensity)),
          Color.fromARGB(intensity, Random().nextInt(intensity),
              Random().nextInt(intensity), Random().nextInt(intensity)),
        ];
      case 2:
        return [
          Color.fromARGB(intensity, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
        ];
      case 3:
        return [
          Color.fromARGB(intensity, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
        ];
      case 4:
        return [
          Color.fromARGB(intensity, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][2][0],
              state.seg[0]['col'][2][1], state.seg[0]['col'][2][2]),
        ];
      case 5:
        return [
          Color.fromARGB(intensity, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][2][0],
              state.seg[0]['col'][2][1], state.seg[0]['col'][2][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][2][0],
              state.seg[0]['col'][2][1], state.seg[0]['col'][2][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][2][0],
              state.seg[0]['col'][2][1], state.seg[0]['col'][2][2]),
          Color.fromARGB(intensity, state.seg[0]['col'][2][0],
              state.seg[0]['col'][2][1], state.seg[0]['col'][2][2]),
        ];
      case 18:
        return [
          Color.fromARGB(intensity, 3, 0, 255),
          Color.fromARGB(intensity, 23, 0, 142),
          Color.fromARGB(intensity, 67, 0, 67),
          Color.fromARGB(intensity, 142, 0, 23),
          Color.fromARGB(intensity, 255, 0, 3),
        ];
      case 46:
        return [
          Color.fromARGB(intensity, 1, 5, 45),
          Color.fromARGB(intensity, 1, 5, 45),
          Color.fromARGB(intensity, 249, 150, 5),
          Color.fromARGB(intensity, 1, 5, 45),
          Color.fromARGB(intensity, 1, 5, 45),
          Color.fromARGB(intensity, 255, 92, 0),
          Color.fromARGB(intensity, 1, 5, 45),
          Color.fromARGB(intensity, 1, 5, 45),
          Color.fromARGB(intensity, 223, 45, 72),
          Color.fromARGB(intensity, 1, 5, 45),
          Color.fromARGB(intensity, 1, 5, 45),
        ];
      case 63:
        return [
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 57, 227, 233),
          Color.fromARGB(intensity, 255, 255, 8),
          Color.fromARGB(intensity, 255, 255, 255),
          Color.fromARGB(intensity, 255, 255, 8),
          Color.fromARGB(intensity, 57, 227, 233),
          Color.fromARGB(intensity, 0, 0, 0),
        ];
      case 51:
        return [
          Color.fromARGB(intensity, 0, 28, 112),
          Color.fromARGB(intensity, 32, 96, 255),
          Color.fromARGB(intensity, 0, 243, 45),
          Color.fromARGB(intensity, 12, 95, 82),
          Color.fromARGB(intensity, 25, 190, 95),
          Color.fromARGB(intensity, 40, 170, 80),
        ];
      case 50:
        return [
          Color.fromARGB(intensity, 1, 5, 45),
          Color.fromARGB(intensity, 0, 200, 23),
          Color.fromARGB(intensity, 0, 255, 0),
          Color.fromARGB(intensity, 0, 243, 45),
          Color.fromARGB(intensity, 0, 135, 7),
          Color.fromARGB(intensity, 1, 5, 45),
        ];
      case 55:
        return [
          Color.fromARGB(intensity, 17, 177, 13),
          Color.fromARGB(intensity, 121, 242, 5),
          Color.fromARGB(intensity, 25, 173, 121),
          Color.fromARGB(intensity, 250, 77, 127),
          Color.fromARGB(intensity, 171, 101, 221),
        ];
      case 39:
        return [
          Color.fromARGB(intensity, 26, 1, 1),
          Color.fromARGB(intensity, 67, 4, 1),
          Color.fromARGB(intensity, 118, 14, 1),
          Color.fromARGB(intensity, 137, 152, 52),
          Color.fromARGB(intensity, 113, 65, 1),
          Color.fromARGB(intensity, 133, 149, 59),
          Color.fromARGB(intensity, 137, 152, 52),
          Color.fromARGB(intensity, 113, 65, 1),
          Color.fromARGB(intensity, 139, 154, 46),
          Color.fromARGB(intensity, 113, 13, 1),
          Color.fromARGB(intensity, 55, 3, 1),
          Color.fromARGB(intensity, 17, 1, 1),
          Color.fromARGB(intensity, 17, 1, 1),
        ];
      case 26:
        return [
          Color.fromARGB(intensity, 1, 5, 0),
          Color.fromARGB(intensity, 32, 23, 1),
          Color.fromARGB(intensity, 161, 55, 1),
          Color.fromARGB(intensity, 229, 144, 1),
          Color.fromARGB(intensity, 39, 142, 74),
          Color.fromARGB(intensity, 1, 4, 1),
        ];
      case 22:
        return [
          Color.fromARGB(intensity, 255, 252, 214),
          Color.fromARGB(intensity, 255, 252, 214),
          Color.fromARGB(intensity, 255, 252, 214),
          Color.fromARGB(intensity, 190, 191, 115),
          Color.fromARGB(intensity, 137, 141, 52),
          Color.fromARGB(intensity, 112, 255, 205),
          Color.fromARGB(intensity, 51, 246, 214),
          Color.fromARGB(intensity, 17, 235, 226),
          Color.fromARGB(intensity, 2, 193, 199),
          Color.fromARGB(intensity, 0, 156, 174),
          Color.fromARGB(intensity, 1, 101, 115),
          Color.fromARGB(intensity, 1, 59, 71),
          Color.fromARGB(intensity, 7, 131, 170),
          Color.fromARGB(intensity, 1, 90, 151),
          Color.fromARGB(intensity, 0, 56, 133),
        ];
      case 67:
        return [
          Color.fromARGB(intensity, 1, 1, 1),
          Color.fromARGB(intensity, 4, 1, 11),
          Color.fromARGB(intensity, 10, 1, 3),
          Color.fromARGB(intensity, 161, 4, 29),
          Color.fromARGB(intensity, 255, 86, 123),
          Color.fromARGB(intensity, 125, 16, 160),
          Color.fromARGB(intensity, 35, 13, 223),
          Color.fromARGB(intensity, 18, 2, 18),
        ];
      case 15:
        return [
          Color.fromARGB(intensity, 1, 6, 7),
          Color.fromARGB(intensity, 1, 99, 111),
          Color.fromARGB(intensity, 144, 209, 255),
          Color.fromARGB(intensity, 0, 73, 82),
        ];
      case 48:
        return [
          Color.fromARGB(intensity, 184, 4, 0),
          Color.fromARGB(intensity, 184, 4, 0),
          Color.fromARGB(intensity, 144, 44, 2),
          Color.fromARGB(intensity, 144, 44, 2),
          Color.fromARGB(intensity, 4, 96, 2),
          Color.fromARGB(intensity, 4, 96, 2),
          Color.fromARGB(intensity, 7, 7, 88),
          Color.fromARGB(intensity, 7, 7, 88),
        ];
      case 52:
        return [
          Color.fromARGB(intensity, 6, 126, 2),
          Color.fromARGB(intensity, 6, 126, 2),
          Color.fromARGB(intensity, 4, 30, 114),
          Color.fromARGB(intensity, 4, 30, 114),
          Color.fromARGB(intensity, 255, 5, 0),
          Color.fromARGB(intensity, 255, 5, 0),
          Color.fromARGB(intensity, 196, 57, 2),
          Color.fromARGB(intensity, 196, 57, 2),
          Color.fromARGB(intensity, 137, 85, 2),
          Color.fromARGB(intensity, 137, 85, 2),
        ];
      case 53:
        return [
          Color.fromARGB(intensity, 255, 5, 0),
          Color.fromARGB(intensity, 255, 5, 0),
          Color.fromARGB(intensity, 196, 57, 2),
          Color.fromARGB(intensity, 196, 57, 2),
          Color.fromARGB(intensity, 6, 126, 2),
          Color.fromARGB(intensity, 6, 126, 2),
          Color.fromARGB(intensity, 4, 30, 114),
          Color.fromARGB(intensity, 4, 30, 114),
        ];
      case 57:
        return [
          Color.fromARGB(intensity, 229, 227, 1),
          Color.fromARGB(intensity, 227, 101, 3),
          Color.fromARGB(intensity, 40, 1, 80),
          Color.fromARGB(intensity, 17, 1, 79),
          Color.fromARGB(intensity, 0, 0, 45),
        ];
      case 70:
        return [
          Color.fromARGB(intensity, 39, 33, 34),
          Color.fromARGB(intensity, 4, 6, 15),
          Color.fromARGB(intensity, 49, 29, 22),
          Color.fromARGB(intensity, 224, 173, 1),
          Color.fromARGB(intensity, 177, 35, 5),
          Color.fromARGB(intensity, 4, 6, 15),
          Color.fromARGB(intensity, 255, 114, 6),
          Color.fromARGB(intensity, 224, 173, 1),
          Color.fromARGB(intensity, 39, 33, 34),
          Color.fromARGB(intensity, 1, 1, 1),
        ];
      case 7:
        return [
          Color.fromARGB(intensity, 0, 0, 255),
          Color.fromARGB(intensity, 0, 0, 139),
          Color.fromARGB(intensity, 0, 0, 139),
          Color.fromARGB(intensity, 0, 0, 139),
          Color.fromARGB(intensity, 0, 0, 139),
          Color.fromARGB(intensity, 0, 0, 139),
          Color.fromARGB(intensity, 0, 0, 139),
          Color.fromARGB(intensity, 0, 0, 139),
          Color.fromARGB(intensity, 0, 0, 255),
          Color.fromARGB(intensity, 0, 0, 139),
          Color.fromARGB(intensity, 135, 206, 235),
          Color.fromARGB(intensity, 135, 206, 235),
          Color.fromARGB(intensity, 173, 216, 230),
          Color.fromARGB(intensity, 255, 255, 255),
          Color.fromARGB(intensity, 173, 216, 230),
          Color.fromARGB(intensity, 135, 206, 235),
        ];
      case 37:
        return [
          Color.fromARGB(intensity, 10, 85, 5),
          Color.fromARGB(intensity, 29, 109, 18),
          Color.fromARGB(intensity, 59, 138, 42),
          Color.fromARGB(intensity, 83, 99, 52),
          Color.fromARGB(intensity, 110, 66, 64),
          Color.fromARGB(intensity, 123, 49, 65),
          Color.fromARGB(intensity, 139, 35, 66),
          Color.fromARGB(intensity, 192, 117, 98),
          Color.fromARGB(intensity, 255, 255, 137),
          Color.fromARGB(intensity, 100, 180, 155),
          Color.fromARGB(intensity, 22, 121, 174),
        ];
      case 24:
        return [
          Color.fromARGB(intensity, 8, 3, 0),
          Color.fromARGB(intensity, 23, 7, 0),
          Color.fromARGB(intensity, 75, 38, 6),
          Color.fromARGB(intensity, 169, 99, 38),
          Color.fromARGB(intensity, 213, 169, 119),
          Color.fromARGB(intensity, 255, 255, 255),
          Color.fromARGB(intensity, 135, 255, 138),
          Color.fromARGB(intensity, 22, 255, 24),
          Color.fromARGB(intensity, 0, 255, 0),
          Color.fromARGB(intensity, 0, 136, 0),
          Color.fromARGB(intensity, 0, 55, 0),
          Color.fromARGB(intensity, 0, 55, 0),
        ];
      case 30:
        return [
          Color.fromARGB(intensity, 47, 30, 2),
          Color.fromARGB(intensity, 213, 147, 24),
          Color.fromARGB(intensity, 103, 219, 52),
          Color.fromARGB(intensity, 3, 219, 207),
          Color.fromARGB(intensity, 1, 48, 214),
          Color.fromARGB(intensity, 1, 1, 111),
          Color.fromARGB(intensity, 1, 7, 33),
        ];
      case 59:
        return [
          Color.fromARGB(intensity, 184, 1, 128),
          Color.fromARGB(intensity, 1, 193, 182),
          Color.fromARGB(intensity, 153, 227, 190),
          Color.fromARGB(intensity, 255, 255, 255),
        ];
      case 35:
        return [
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 18, 0, 0),
          Color.fromARGB(intensity, 113, 0, 0),
          Color.fromARGB(intensity, 142, 3, 1),
          Color.fromARGB(intensity, 175, 17, 1),
          Color.fromARGB(intensity, 213, 44, 2),
          Color.fromARGB(intensity, 255, 82, 4),
          Color.fromARGB(intensity, 255, 115, 4),
          Color.fromARGB(intensity, 255, 156, 4),
          Color.fromARGB(intensity, 255, 203, 4),
          Color.fromARGB(intensity, 255, 255, 4),
          Color.fromARGB(intensity, 255, 255, 71),
          Color.fromARGB(intensity, 255, 255, 255),
        ];
      case 10:
        return [
          Color.fromARGB(intensity, 0, 100, 0),
          Color.fromARGB(intensity, 0, 100, 0),
          Color.fromARGB(intensity, 85, 107, 47),
          Color.fromARGB(intensity, 0, 100, 0),
          Color.fromARGB(intensity, 0, 128, 0),
          Color.fromARGB(intensity, 34, 139, 34),
          Color.fromARGB(intensity, 107, 142, 35),
          Color.fromARGB(intensity, 0, 128, 0),
          Color.fromARGB(intensity, 46, 139, 87),
          Color.fromARGB(intensity, 102, 205, 170),
          Color.fromARGB(intensity, 50, 205, 50),
          Color.fromARGB(intensity, 154, 205, 50),
          Color.fromARGB(intensity, 144, 238, 144),
          Color.fromARGB(intensity, 124, 252, 0),
          Color.fromARGB(intensity, 102, 205, 170),
          Color.fromARGB(intensity, 34, 139, 34),
        ];
      case 32:
        return [
          Color.fromARGB(intensity, 2, 1, 1),
          Color.fromARGB(intensity, 18, 1, 0),
          Color.fromARGB(intensity, 69, 29, 1),
          Color.fromARGB(intensity, 167, 135, 10),
          Color.fromARGB(intensity, 46, 56, 4),
        ];
      case 28:
        return [
          Color.fromARGB(intensity, 247, 176, 247),
          Color.fromARGB(intensity, 255, 136, 255),
          Color.fromARGB(intensity, 220, 29, 226),
          Color.fromARGB(intensity, 7, 82, 178),
          Color.fromARGB(intensity, 1, 124, 109),
          Color.fromARGB(intensity, 1, 124, 109),
        ];
      case 29:
        return [
          Color.fromARGB(intensity, 1, 124, 109),
          Color.fromARGB(intensity, 1, 93, 79),
          Color.fromARGB(intensity, 52, 65, 1),
          Color.fromARGB(intensity, 115, 127, 1),
          Color.fromARGB(intensity, 52, 65, 1),
          Color.fromARGB(intensity, 1, 86, 72),
          Color.fromARGB(intensity, 0, 55, 45),
          Color.fromARGB(intensity, 0, 55, 45),
        ];
      case 36:
        return [
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 0, 9, 45),
          Color.fromARGB(intensity, 0, 38, 255),
          Color.fromARGB(intensity, 3, 100, 255),
          Color.fromARGB(intensity, 23, 199, 255),
          Color.fromARGB(intensity, 100, 235, 255),
          Color.fromARGB(intensity, 255, 255, 255),
        ];
      case 31:
        return [
          Color.fromARGB(intensity, 194, 1, 1),
          Color.fromARGB(intensity, 1, 29, 18),
          Color.fromARGB(intensity, 57, 131, 28),
          Color.fromARGB(intensity, 113, 1, 1),
        ];
      case 25:
        return [
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 2, 25, 1),
          Color.fromARGB(intensity, 15, 115, 5),
          Color.fromARGB(intensity, 79, 213, 1),
          Color.fromARGB(intensity, 126, 211, 47),
          Color.fromARGB(intensity, 188, 209, 247),
          Color.fromARGB(intensity, 144, 182, 205),
          Color.fromARGB(intensity, 59, 117, 250),
          Color.fromARGB(intensity, 1, 37, 192),
        ];
      case 8:
        return [
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 128, 0, 0),
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 128, 0, 0),
          Color.fromARGB(intensity, 139, 0, 0),
          Color.fromARGB(intensity, 128, 0, 0),
          Color.fromARGB(intensity, 139, 0, 0),
          Color.fromARGB(intensity, 139, 0, 0),
          Color.fromARGB(intensity, 139, 0, 0),
          Color.fromARGB(intensity, 255, 0, 0),
          Color.fromARGB(intensity, 255, 165, 0),
          Color.fromARGB(intensity, 255, 255, 255),
          Color.fromARGB(intensity, 255, 165, 0),
          Color.fromARGB(intensity, 255, 0, 0),
          Color.fromARGB(intensity, 139, 0, 0),
          Color.fromARGB(intensity, 0, 0, 0),
        ];
      case 38:
        return [
          Color.fromARGB(intensity, 19, 2, 39),
          Color.fromARGB(intensity, 26, 4, 45),
          Color.fromARGB(intensity, 33, 6, 52),
          Color.fromARGB(intensity, 68, 62, 125),
          Color.fromARGB(intensity, 118, 187, 240),
          Color.fromARGB(intensity, 163, 215, 247),
          Color.fromARGB(intensity, 217, 244, 255),
          Color.fromARGB(intensity, 159, 149, 221),
          Color.fromARGB(intensity, 113, 78, 188),
          Color.fromARGB(intensity, 128, 57, 155),
          Color.fromARGB(intensity, 146, 40, 123),
        ];
      case 65:
        return [
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 1, 1, 1),
          Color.fromARGB(intensity, 5, 5, 6),
          Color.fromARGB(intensity, 5, 5, 6),
          Color.fromARGB(intensity, 10, 1, 12),
          Color.fromARGB(intensity, 0, 0, 0),
        ];
      case 40:
        return [
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 0, 0, 45),
          Color.fromARGB(intensity, 0, 0, 255),
          Color.fromARGB(intensity, 42, 0, 255),
          Color.fromARGB(intensity, 255, 0, 255),
          Color.fromARGB(intensity, 255, 55, 255),
          Color.fromARGB(intensity, 255, 255, 255),
        ];
      case 41:
        return [
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 42, 0, 45),
          Color.fromARGB(intensity, 255, 0, 255),
          Color.fromARGB(intensity, 255, 0, 45),
          Color.fromARGB(intensity, 255, 0, 0),
        ];
      case 9:
        return [
          Color.fromARGB(intensity, 25, 25, 112),
          Color.fromARGB(intensity, 0, 0, 139),
          Color.fromARGB(intensity, 25, 25, 112),
          Color.fromARGB(intensity, 0, 0, 128),
          Color.fromARGB(intensity, 0, 0, 139),
          Color.fromARGB(intensity, 0, 0, 205),
          Color.fromARGB(intensity, 46, 139, 87),
          Color.fromARGB(intensity, 0, 128, 128),
          Color.fromARGB(intensity, 95, 158, 160),
          Color.fromARGB(intensity, 0, 0, 255),
          Color.fromARGB(intensity, 0, 139, 139),
          Color.fromARGB(intensity, 100, 149, 237),
          Color.fromARGB(intensity, 127, 255, 212),
          Color.fromARGB(intensity, 46, 139, 87),
          Color.fromARGB(intensity, 0, 255, 255),
          Color.fromARGB(intensity, 135, 206, 250),
        ];
      case 44:
        return [
          Color.fromARGB(intensity, 0, 150, 92),
          Color.fromARGB(intensity, 0, 150, 92),
          Color.fromARGB(intensity, 255, 72, 0),
          Color.fromARGB(intensity, 255, 72, 0),
        ];

      case 47:
        return [
          Color.fromARGB(intensity, 255, 95, 23),
          Color.fromARGB(intensity, 255, 82, 0),
          Color.fromARGB(intensity, 223, 13, 8),
          Color.fromARGB(intensity, 144, 44, 2),
          Color.fromARGB(intensity, 255, 110, 17),
          Color.fromARGB(intensity, 255, 69, 0),
          Color.fromARGB(intensity, 158, 13, 11),
          Color.fromARGB(intensity, 241, 82, 17),
          Color.fromARGB(intensity, 213, 37, 4),
        ];
      case 6:
        return [
          Color.fromARGB(intensity, 85, 0, 171),
          Color.fromARGB(intensity, 132, 0, 124),
          Color.fromARGB(intensity, 181, 0, 75),
          Color.fromARGB(intensity, 229, 0, 27),
          Color.fromARGB(intensity, 232, 23, 0),
          Color.fromARGB(intensity, 184, 71, 0),
          Color.fromARGB(intensity, 171, 119, 0),
          Color.fromARGB(intensity, 171, 171, 0),
          Color.fromARGB(intensity, 171, 85, 0),
          Color.fromARGB(intensity, 221, 34, 0),
          Color.fromARGB(intensity, 242, 0, 14),
          Color.fromARGB(intensity, 194, 0, 62),
          Color.fromARGB(intensity, 143, 0, 113),
          Color.fromARGB(intensity, 95, 0, 161),
          Color.fromARGB(intensity, 47, 0, 208),
          Color.fromARGB(intensity, 0, 7, 249),
        ];
      case 20:
        return [
          Color.fromARGB(intensity, 10, 62, 123),
          Color.fromARGB(intensity, 56, 130, 103),
          Color.fromARGB(intensity, 153, 225, 85),
          Color.fromARGB(intensity, 199, 217, 68),
          Color.fromARGB(intensity, 255, 207, 54),
          Color.fromARGB(intensity, 247, 152, 57),
          Color.fromARGB(intensity, 239, 107, 61),
          Color.fromARGB(intensity, 247, 152, 57),
          Color.fromARGB(intensity, 255, 207, 54),
          Color.fromARGB(intensity, 255, 227, 48),
          Color.fromARGB(intensity, 255, 248, 42),
        ];
      case 61:
        return [
          Color.fromARGB(intensity, 255, 255, 255),
          Color.fromARGB(intensity, 7, 12, 255),
          Color.fromARGB(intensity, 227, 1, 127),
          Color.fromARGB(intensity, 227, 1, 127),
          Color.fromARGB(intensity, 255, 255, 255),
          Color.fromARGB(intensity, 227, 1, 127),
          Color.fromARGB(intensity, 45, 1, 99),
          Color.fromARGB(intensity, 255, 255, 255),
        ];
      case 11:
        return [
          Color.fromARGB(intensity, 255, 0, 0),
          Color.fromARGB(intensity, 213, 42, 0),
          Color.fromARGB(intensity, 171, 85, 0),
          Color.fromARGB(intensity, 171, 127, 0),
          Color.fromARGB(intensity, 171, 171, 0),
          Color.fromARGB(intensity, 86, 213, 0),
          Color.fromARGB(intensity, 0, 255, 0),
          Color.fromARGB(intensity, 0, 213, 42),
          Color.fromARGB(intensity, 0, 171, 85),
          Color.fromARGB(intensity, 0, 86, 170),
          Color.fromARGB(intensity, 0, 0, 255),
          Color.fromARGB(intensity, 42, 0, 213),
          Color.fromARGB(intensity, 85, 0, 171),
          Color.fromARGB(intensity, 127, 0, 129),
          Color.fromARGB(intensity, 171, 0, 85),
          Color.fromARGB(intensity, 213, 0, 43),
        ];
      case 12:
        return [
          Color.fromARGB(intensity, 255, 0, 0),
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 171, 85, 0),
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 171, 171, 0),
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 0, 255, 0),
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 0, 171, 85),
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 0, 0, 255),
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 85, 0, 171),
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 171, 0, 85),
          Color.fromARGB(intensity, 0, 0, 0),
        ];
      case 16:
        return [
          Color.fromARGB(intensity, 4, 1, 70),
          Color.fromARGB(intensity, 55, 1, 30),
          Color.fromARGB(intensity, 255, 4, 7),
          Color.fromARGB(intensity, 59, 2, 29),
          Color.fromARGB(intensity, 11, 3, 50),
          Color.fromARGB(intensity, 39, 8, 60),
          Color.fromARGB(intensity, 112, 19, 40),
          Color.fromARGB(intensity, 78, 11, 39),
          Color.fromARGB(intensity, 29, 8, 59),
        ];
      case 66:
        return [
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 227, 1, 1),
          Color.fromARGB(intensity, 249, 199, 95),
          Color.fromARGB(intensity, 227, 1, 1),
          Color.fromARGB(intensity, 0, 0, 0),
        ];
      case 62:
        return [
          Color.fromARGB(intensity, 3, 13, 43),
          Color.fromARGB(intensity, 78, 141, 240),
          Color.fromARGB(intensity, 255, 0, 0),
          Color.fromARGB(intensity, 28, 1, 1),
        ];
      case 68:
        return [
          Color.fromARGB(intensity, 31, 1, 27),
          Color.fromARGB(intensity, 34, 1, 16),
          Color.fromARGB(intensity, 137, 5, 9),
          Color.fromARGB(intensity, 213, 128, 10),
          Color.fromARGB(intensity, 199, 22, 1),
          Color.fromARGB(intensity, 199, 9, 6),
          Color.fromARGB(intensity, 1, 0, 1),
        ];
      case 69:
        return [
          Color.fromARGB(intensity, 247, 5, 0),
          Color.fromARGB(intensity, 255, 67, 1),
          Color.fromARGB(intensity, 234, 88, 11),
          Color.fromARGB(intensity, 234, 176, 51),
          Color.fromARGB(intensity, 229, 28, 1),
          Color.fromARGB(intensity, 113, 12, 1),
          Color.fromARGB(intensity, 255, 225, 44),
          Color.fromARGB(intensity, 113, 12, 1),
          Color.fromARGB(intensity, 244, 209, 88),
          Color.fromARGB(intensity, 255, 28, 1),
          Color.fromARGB(intensity, 53, 1, 1),
        ];
      case 56:
        return [
          Color.fromARGB(intensity, 227, 101, 3),
          Color.fromARGB(intensity, 194, 18, 19),
          Color.fromARGB(intensity, 92, 8, 192),
        ];
      case 33:
        return [
          Color.fromARGB(intensity, 113, 91, 147),
          Color.fromARGB(intensity, 157, 88, 78),
          Color.fromARGB(intensity, 208, 85, 33),
          Color.fromARGB(intensity, 255, 29, 11),
          Color.fromARGB(intensity, 137, 31, 39),
          Color.fromARGB(intensity, 59, 33, 89),
        ];
      case 14:
        return [
          Color.fromARGB(intensity, 1, 14, 5),
          Color.fromARGB(intensity, 16, 36, 14),
          Color.fromARGB(intensity, 56, 68, 30),
          Color.fromARGB(intensity, 150, 156, 99),
          Color.fromARGB(intensity, 150, 156, 99),
        ];
      case 49:
        return [
          Color.fromARGB(intensity, 196, 19, 10),
          Color.fromARGB(intensity, 255, 69, 45),
          Color.fromARGB(intensity, 223, 45, 72),
          Color.fromARGB(intensity, 255, 82, 103),
          Color.fromARGB(intensity, 223, 13, 17),
        ];

      case 60:
        return [
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 1, 1, 3),
          Color.fromARGB(intensity, 8, 1, 22),
          Color.fromARGB(intensity, 4, 6, 89),
          Color.fromARGB(intensity, 2, 25, 216),
          Color.fromARGB(intensity, 7, 10, 99),
          Color.fromARGB(intensity, 15, 2, 31),
          Color.fromARGB(intensity, 2, 1, 5),
          Color.fromARGB(intensity, 0, 0, 0),
        ];
      case 27:
        return [
          Color.fromARGB(intensity, 255, 33, 4),
          Color.fromARGB(intensity, 255, 68, 25),
          Color.fromARGB(intensity, 255, 7, 25),
          Color.fromARGB(intensity, 255, 82, 103),
          Color.fromARGB(intensity, 255, 255, 242),
          Color.fromARGB(intensity, 42, 255, 22),
          Color.fromARGB(intensity, 87, 255, 65),
        ];
      case 19:
        return [
          Color.fromARGB(intensity, 126, 11, 255),
          Color.fromARGB(intensity, 197, 1, 22),
          Color.fromARGB(intensity, 210, 157, 172),
          Color.fromARGB(intensity, 157, 3, 112),
          Color.fromARGB(intensity, 157, 3, 112),
        ];
      case 13:
        return [
          Color.fromARGB(intensity, 120, 0, 0),
          Color.fromARGB(intensity, 179, 22, 0),
          Color.fromARGB(intensity, 255, 104, 0),
          Color.fromARGB(intensity, 167, 22, 18),
          Color.fromARGB(intensity, 100, 0, 103),
          Color.fromARGB(intensity, 16, 0, 130),
          Color.fromARGB(intensity, 0, 0, 160),
        ];
      case 21:
        return [
          Color.fromARGB(intensity, 110, 49, 11),
          Color.fromARGB(intensity, 55, 34, 10),
          Color.fromARGB(intensity, 22, 22, 9),
          Color.fromARGB(intensity, 239, 124, 8),
          Color.fromARGB(intensity, 220, 156, 27),
          Color.fromARGB(intensity, 203, 193, 61),
          Color.fromARGB(intensity, 33, 53, 56),
          Color.fromARGB(intensity, 0, 1, 52),
        ];
      case 54:
        return [
          Color.fromARGB(intensity, 1, 27, 105),
          Color.fromARGB(intensity, 1, 40, 127),
          Color.fromARGB(intensity, 1, 70, 168),
          Color.fromARGB(intensity, 1, 92, 197),
          Color.fromARGB(intensity, 1, 119, 221),
          Color.fromARGB(intensity, 3, 130, 151),
          Color.fromARGB(intensity, 23, 156, 149),
          Color.fromARGB(intensity, 67, 182, 112),
          Color.fromARGB(intensity, 121, 201, 52),
          Color.fromARGB(intensity, 142, 203, 11),
          Color.fromARGB(intensity, 224, 223, 1),
          Color.fromARGB(intensity, 252, 187, 2),
          Color.fromARGB(intensity, 247, 147, 1),
          Color.fromARGB(intensity, 237, 87, 1),
          Color.fromARGB(intensity, 229, 43, 1),
          Color.fromARGB(intensity, 171, 2, 2),
          Color.fromARGB(intensity, 80, 3, 3),
          Color.fromARGB(intensity, 80, 3, 3),
        ];
      case 34:
        return [
          Color.fromARGB(intensity, 0, 1, 255),
          Color.fromARGB(intensity, 3, 68, 45),
          Color.fromARGB(intensity, 23, 255, 0),
          Color.fromARGB(intensity, 100, 68, 1),
          Color.fromARGB(intensity, 255, 1, 4),
        ];
      case 45:
        return [
          Color.fromARGB(intensity, 1, 2, 14),
          Color.fromARGB(intensity, 2, 5, 35),
          Color.fromARGB(intensity, 13, 135, 92),
          Color.fromARGB(intensity, 43, 255, 193),
          Color.fromARGB(intensity, 247, 7, 249),
          Color.fromARGB(intensity, 193, 17, 208),
          Color.fromARGB(intensity, 39, 255, 154),
          Color.fromARGB(intensity, 4, 213, 236),
          Color.fromARGB(intensity, 39, 252, 135),
          Color.fromARGB(intensity, 193, 213, 253),
          Color.fromARGB(intensity, 255, 249, 255),
        ];
      case 58:
        return [
          Color.fromARGB(intensity, 1, 221, 53),
          Color.fromARGB(intensity, 73, 3, 178),
        ];
      case 23:
        return [
          Color.fromARGB(intensity, 4, 1, 1),
          Color.fromARGB(intensity, 16, 0, 1),
          Color.fromARGB(intensity, 97, 104, 3),
          Color.fromARGB(intensity, 255, 131, 19),
          Color.fromARGB(intensity, 67, 9, 4),
          Color.fromARGB(intensity, 16, 0, 1),
          Color.fromARGB(intensity, 4, 1, 1),
          Color.fromARGB(intensity, 4, 1, 1),
        ];
      case 43:
        return [
          Color.fromARGB(intensity, 0, 0, 255),
          Color.fromARGB(intensity, 0, 55, 255),
          Color.fromARGB(intensity, 0, 255, 255),
          Color.fromARGB(intensity, 42, 255, 45),
          Color.fromARGB(intensity, 255, 255, 0),
        ];
      case 64:
        return [
          Color.fromARGB(intensity, 4, 2, 9),
          Color.fromARGB(intensity, 16, 0, 47),
          Color.fromARGB(intensity, 24, 0, 16),
          Color.fromARGB(intensity, 144, 9, 1),
          Color.fromARGB(intensity, 179, 45, 1),
          Color.fromARGB(intensity, 220, 114, 2),
          Color.fromARGB(intensity, 234, 237, 1),
        ];
      case 17:
        return [
          Color.fromARGB(intensity, 188, 135, 1),
          Color.fromARGB(intensity, 46, 7, 1),
        ];
      case 42:
        return [
          Color.fromARGB(intensity, 0, 0, 0),
          Color.fromARGB(intensity, 42, 0, 0),
          Color.fromARGB(intensity, 255, 0, 0),
          Color.fromARGB(intensity, 255, 0, 45),
          Color.fromARGB(intensity, 255, 0, 255),
          Color.fromARGB(intensity, 255, 55, 45),
          Color.fromARGB(intensity, 255, 255, 0),
        ];

      default:
        return const [
          Color(0xFF00FF00),
          Color(0xFF0000FF),
        ];
    }
  }
}
