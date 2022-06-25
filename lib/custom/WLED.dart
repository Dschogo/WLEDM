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

  List<Color> getGradient(int id) {
    switch (id) {
      case 1:
        return [
          Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
              Random().nextInt(255)),
          Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
              Random().nextInt(255)),
          Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
              Random().nextInt(255)),
        ];
      case 2:
        return [
          Color.fromARGB(255, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(255, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(255, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
        ];
      case 3:
        return [
          Color.fromARGB(255, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(255, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
        ];
      case 4:
        return [
          Color.fromARGB(255, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(255, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
          Color.fromARGB(255, state.seg[0]['col'][2][0],
              state.seg[0]['col'][2][1], state.seg[0]['col'][2][2]),
        ];
      case 5:
        return [
          Color.fromARGB(255, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(255, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(255, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(255, state.seg[0]['col'][0][0],
              state.seg[0]['col'][0][1], state.seg[0]['col'][0][2]),
          Color.fromARGB(255, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
          Color.fromARGB(255, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
          Color.fromARGB(255, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
          Color.fromARGB(255, state.seg[0]['col'][1][0],
              state.seg[0]['col'][1][1], state.seg[0]['col'][1][2]),
          Color.fromARGB(255, state.seg[0]['col'][2][0],
              state.seg[0]['col'][2][1], state.seg[0]['col'][2][2]),
          Color.fromARGB(255, state.seg[0]['col'][2][0],
              state.seg[0]['col'][2][1], state.seg[0]['col'][2][2]),
          Color.fromARGB(255, state.seg[0]['col'][2][0],
              state.seg[0]['col'][2][1], state.seg[0]['col'][2][2]),
          Color.fromARGB(255, state.seg[0]['col'][2][0],
              state.seg[0]['col'][2][1], state.seg[0]['col'][2][2]),
        ];
      case 18:
        return const [
          Color.fromARGB(255, 3, 0, 255),
          Color.fromARGB(255, 23, 0, 142),
          Color.fromARGB(255, 67, 0, 67),
          Color.fromARGB(255, 142, 0, 23),
          Color.fromARGB(255, 255, 0, 3),
        ];
      case 46:
        return const [
          Color.fromARGB(255, 1, 5, 45),
          Color.fromARGB(255, 1, 5, 45),
          Color.fromARGB(255, 249, 150, 5),
          Color.fromARGB(255, 1, 5, 45),
          Color.fromARGB(255, 1, 5, 45),
          Color.fromARGB(255, 255, 92, 0),
          Color.fromARGB(255, 1, 5, 45),
          Color.fromARGB(255, 1, 5, 45),
          Color.fromARGB(255, 223, 45, 72),
          Color.fromARGB(255, 1, 5, 45),
          Color.fromARGB(255, 1, 5, 45),
        ];
      case 63:
        return const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 57, 227, 233),
          Color.fromARGB(255, 255, 255, 8),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 8),
          Color.fromARGB(255, 57, 227, 233),
          Color.fromARGB(255, 0, 0, 0),
        ];
      case 51:
        return const [
          Color.fromARGB(255, 0, 28, 112),
          Color.fromARGB(255, 32, 96, 255),
          Color.fromARGB(255, 0, 243, 45),
          Color.fromARGB(255, 12, 95, 82),
          Color.fromARGB(255, 25, 190, 95),
          Color.fromARGB(255, 40, 170, 80),
        ];
      case 50:
        return const [
          Color.fromARGB(255, 1, 5, 45),
          Color.fromARGB(255, 0, 200, 23),
          Color.fromARGB(255, 0, 255, 0),
          Color.fromARGB(255, 0, 243, 45),
          Color.fromARGB(255, 0, 135, 7),
          Color.fromARGB(255, 1, 5, 45),
        ];
      case 55:
        return const [
          Color.fromARGB(255, 17, 177, 13),
          Color.fromARGB(255, 121, 242, 5),
          Color.fromARGB(255, 25, 173, 121),
          Color.fromARGB(255, 250, 77, 127),
          Color.fromARGB(255, 171, 101, 221),
        ];
      case 39:
        return const [
          Color.fromARGB(255, 26, 1, 1),
          Color.fromARGB(255, 67, 4, 1),
          Color.fromARGB(255, 118, 14, 1),
          Color.fromARGB(255, 137, 152, 52),
          Color.fromARGB(255, 113, 65, 1),
          Color.fromARGB(255, 133, 149, 59),
          Color.fromARGB(255, 137, 152, 52),
          Color.fromARGB(255, 113, 65, 1),
          Color.fromARGB(255, 139, 154, 46),
          Color.fromARGB(255, 113, 13, 1),
          Color.fromARGB(255, 55, 3, 1),
          Color.fromARGB(255, 17, 1, 1),
          Color.fromARGB(255, 17, 1, 1),
        ];
      case 26:
        return const [
          Color.fromARGB(255, 1, 5, 0),
          Color.fromARGB(255, 32, 23, 1),
          Color.fromARGB(255, 161, 55, 1),
          Color.fromARGB(255, 229, 144, 1),
          Color.fromARGB(255, 39, 142, 74),
          Color.fromARGB(255, 1, 4, 1),
        ];
      case 22:
        return const [
          Color.fromARGB(255, 255, 252, 214),
          Color.fromARGB(255, 255, 252, 214),
          Color.fromARGB(255, 255, 252, 214),
          Color.fromARGB(255, 190, 191, 115),
          Color.fromARGB(255, 137, 141, 52),
          Color.fromARGB(255, 112, 255, 205),
          Color.fromARGB(255, 51, 246, 214),
          Color.fromARGB(255, 17, 235, 226),
          Color.fromARGB(255, 2, 193, 199),
          Color.fromARGB(255, 0, 156, 174),
          Color.fromARGB(255, 1, 101, 115),
          Color.fromARGB(255, 1, 59, 71),
          Color.fromARGB(255, 7, 131, 170),
          Color.fromARGB(255, 1, 90, 151),
          Color.fromARGB(255, 0, 56, 133),
        ];
      case 67:
        return const [
          Color.fromARGB(255, 1, 1, 1),
          Color.fromARGB(255, 4, 1, 11),
          Color.fromARGB(255, 10, 1, 3),
          Color.fromARGB(255, 161, 4, 29),
          Color.fromARGB(255, 255, 86, 123),
          Color.fromARGB(255, 125, 16, 160),
          Color.fromARGB(255, 35, 13, 223),
          Color.fromARGB(255, 18, 2, 18),
        ];
      case 15:
        return const [
          Color.fromARGB(255, 1, 6, 7),
          Color.fromARGB(255, 1, 99, 111),
          Color.fromARGB(255, 144, 209, 255),
          Color.fromARGB(255, 0, 73, 82),
        ];
      case 48:
        return const [
          Color.fromARGB(255, 184, 4, 0),
          Color.fromARGB(255, 184, 4, 0),
          Color.fromARGB(255, 144, 44, 2),
          Color.fromARGB(255, 144, 44, 2),
          Color.fromARGB(255, 4, 96, 2),
          Color.fromARGB(255, 4, 96, 2),
          Color.fromARGB(255, 7, 7, 88),
          Color.fromARGB(255, 7, 7, 88),
        ];
      case 52:
        return const [
          Color.fromARGB(255, 6, 126, 2),
          Color.fromARGB(255, 6, 126, 2),
          Color.fromARGB(255, 4, 30, 114),
          Color.fromARGB(255, 4, 30, 114),
          Color.fromARGB(255, 255, 5, 0),
          Color.fromARGB(255, 255, 5, 0),
          Color.fromARGB(255, 196, 57, 2),
          Color.fromARGB(255, 196, 57, 2),
          Color.fromARGB(255, 137, 85, 2),
          Color.fromARGB(255, 137, 85, 2),
        ];
      case 53:
        return const [
          Color.fromARGB(255, 255, 5, 0),
          Color.fromARGB(255, 255, 5, 0),
          Color.fromARGB(255, 196, 57, 2),
          Color.fromARGB(255, 196, 57, 2),
          Color.fromARGB(255, 6, 126, 2),
          Color.fromARGB(255, 6, 126, 2),
          Color.fromARGB(255, 4, 30, 114),
          Color.fromARGB(255, 4, 30, 114),
        ];
      case 57:
        return const [
          Color.fromARGB(255, 229, 227, 1),
          Color.fromARGB(255, 227, 101, 3),
          Color.fromARGB(255, 40, 1, 80),
          Color.fromARGB(255, 17, 1, 79),
          Color.fromARGB(255, 0, 0, 45),
        ];
      case 70:
        return const [
          Color.fromARGB(255, 39, 33, 34),
          Color.fromARGB(255, 4, 6, 15),
          Color.fromARGB(255, 49, 29, 22),
          Color.fromARGB(255, 224, 173, 1),
          Color.fromARGB(255, 177, 35, 5),
          Color.fromARGB(255, 4, 6, 15),
          Color.fromARGB(255, 255, 114, 6),
          Color.fromARGB(255, 224, 173, 1),
          Color.fromARGB(255, 39, 33, 34),
          Color.fromARGB(255, 1, 1, 1),
        ];
      case 7:
        return const [
          Color.fromARGB(255, 0, 0, 255),
          Color.fromARGB(255, 0, 0, 139),
          Color.fromARGB(255, 0, 0, 139),
          Color.fromARGB(255, 0, 0, 139),
          Color.fromARGB(255, 0, 0, 139),
          Color.fromARGB(255, 0, 0, 139),
          Color.fromARGB(255, 0, 0, 139),
          Color.fromARGB(255, 0, 0, 139),
          Color.fromARGB(255, 0, 0, 255),
          Color.fromARGB(255, 0, 0, 139),
          Color.fromARGB(255, 135, 206, 235),
          Color.fromARGB(255, 135, 206, 235),
          Color.fromARGB(255, 173, 216, 230),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 173, 216, 230),
          Color.fromARGB(255, 135, 206, 235),
        ];
      case 37:
        return const [
          Color.fromARGB(255, 10, 85, 5),
          Color.fromARGB(255, 29, 109, 18),
          Color.fromARGB(255, 59, 138, 42),
          Color.fromARGB(255, 83, 99, 52),
          Color.fromARGB(255, 110, 66, 64),
          Color.fromARGB(255, 123, 49, 65),
          Color.fromARGB(255, 139, 35, 66),
          Color.fromARGB(255, 192, 117, 98),
          Color.fromARGB(255, 255, 255, 137),
          Color.fromARGB(255, 100, 180, 155),
          Color.fromARGB(255, 22, 121, 174),
        ];
      case 24:
        return const [
          Color.fromARGB(255, 8, 3, 0),
          Color.fromARGB(255, 23, 7, 0),
          Color.fromARGB(255, 75, 38, 6),
          Color.fromARGB(255, 169, 99, 38),
          Color.fromARGB(255, 213, 169, 119),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 135, 255, 138),
          Color.fromARGB(255, 22, 255, 24),
          Color.fromARGB(255, 0, 255, 0),
          Color.fromARGB(255, 0, 136, 0),
          Color.fromARGB(255, 0, 55, 0),
          Color.fromARGB(255, 0, 55, 0),
        ];
      case 30:
        return const [
          Color.fromARGB(255, 47, 30, 2),
          Color.fromARGB(255, 213, 147, 24),
          Color.fromARGB(255, 103, 219, 52),
          Color.fromARGB(255, 3, 219, 207),
          Color.fromARGB(255, 1, 48, 214),
          Color.fromARGB(255, 1, 1, 111),
          Color.fromARGB(255, 1, 7, 33),
        ];
      case 59:
        return const [
          Color.fromARGB(255, 184, 1, 128),
          Color.fromARGB(255, 1, 193, 182),
          Color.fromARGB(255, 153, 227, 190),
          Color.fromARGB(255, 255, 255, 255),
        ];
      case 35:
        return const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 18, 0, 0),
          Color.fromARGB(255, 113, 0, 0),
          Color.fromARGB(255, 142, 3, 1),
          Color.fromARGB(255, 175, 17, 1),
          Color.fromARGB(255, 213, 44, 2),
          Color.fromARGB(255, 255, 82, 4),
          Color.fromARGB(255, 255, 115, 4),
          Color.fromARGB(255, 255, 156, 4),
          Color.fromARGB(255, 255, 203, 4),
          Color.fromARGB(255, 255, 255, 4),
          Color.fromARGB(255, 255, 255, 71),
          Color.fromARGB(255, 255, 255, 255),
        ];
      case 10:
        return const [
          Color.fromARGB(255, 0, 100, 0),
          Color.fromARGB(255, 0, 100, 0),
          Color.fromARGB(255, 85, 107, 47),
          Color.fromARGB(255, 0, 100, 0),
          Color.fromARGB(255, 0, 128, 0),
          Color.fromARGB(255, 34, 139, 34),
          Color.fromARGB(255, 107, 142, 35),
          Color.fromARGB(255, 0, 128, 0),
          Color.fromARGB(255, 46, 139, 87),
          Color.fromARGB(255, 102, 205, 170),
          Color.fromARGB(255, 50, 205, 50),
          Color.fromARGB(255, 154, 205, 50),
          Color.fromARGB(255, 144, 238, 144),
          Color.fromARGB(255, 124, 252, 0),
          Color.fromARGB(255, 102, 205, 170),
          Color.fromARGB(255, 34, 139, 34),
        ];
      case 32:
        return const [
          Color.fromARGB(255, 2, 1, 1),
          Color.fromARGB(255, 18, 1, 0),
          Color.fromARGB(255, 69, 29, 1),
          Color.fromARGB(255, 167, 135, 10),
          Color.fromARGB(255, 46, 56, 4),
        ];
      case 28:
        return const [
          Color.fromARGB(255, 247, 176, 247),
          Color.fromARGB(255, 255, 136, 255),
          Color.fromARGB(255, 220, 29, 226),
          Color.fromARGB(255, 7, 82, 178),
          Color.fromARGB(255, 1, 124, 109),
          Color.fromARGB(255, 1, 124, 109),
        ];
      case 29:
        return const [
          Color.fromARGB(255, 1, 124, 109),
          Color.fromARGB(255, 1, 93, 79),
          Color.fromARGB(255, 52, 65, 1),
          Color.fromARGB(255, 115, 127, 1),
          Color.fromARGB(255, 52, 65, 1),
          Color.fromARGB(255, 1, 86, 72),
          Color.fromARGB(255, 0, 55, 45),
          Color.fromARGB(255, 0, 55, 45),
        ];
      case 36:
        return const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 0, 9, 45),
          Color.fromARGB(255, 0, 38, 255),
          Color.fromARGB(255, 3, 100, 255),
          Color.fromARGB(255, 23, 199, 255),
          Color.fromARGB(255, 100, 235, 255),
          Color.fromARGB(255, 255, 255, 255),
        ];
      case 31:
        return const [
          Color.fromARGB(255, 194, 1, 1),
          Color.fromARGB(255, 1, 29, 18),
          Color.fromARGB(255, 57, 131, 28),
          Color.fromARGB(255, 113, 1, 1),
        ];
      case 25:
        return const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 2, 25, 1),
          Color.fromARGB(255, 15, 115, 5),
          Color.fromARGB(255, 79, 213, 1),
          Color.fromARGB(255, 126, 211, 47),
          Color.fromARGB(255, 188, 209, 247),
          Color.fromARGB(255, 144, 182, 205),
          Color.fromARGB(255, 59, 117, 250),
          Color.fromARGB(255, 1, 37, 192),
        ];
      case 8:
        return const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 128, 0, 0),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 128, 0, 0),
          Color.fromARGB(255, 139, 0, 0),
          Color.fromARGB(255, 128, 0, 0),
          Color.fromARGB(255, 139, 0, 0),
          Color.fromARGB(255, 139, 0, 0),
          Color.fromARGB(255, 139, 0, 0),
          Color.fromARGB(255, 255, 0, 0),
          Color.fromARGB(255, 255, 165, 0),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 255, 165, 0),
          Color.fromARGB(255, 255, 0, 0),
          Color.fromARGB(255, 139, 0, 0),
          Color.fromARGB(255, 0, 0, 0),
        ];
      case 38:
        return const [
          Color.fromARGB(255, 19, 2, 39),
          Color.fromARGB(255, 26, 4, 45),
          Color.fromARGB(255, 33, 6, 52),
          Color.fromARGB(255, 68, 62, 125),
          Color.fromARGB(255, 118, 187, 240),
          Color.fromARGB(255, 163, 215, 247),
          Color.fromARGB(255, 217, 244, 255),
          Color.fromARGB(255, 159, 149, 221),
          Color.fromARGB(255, 113, 78, 188),
          Color.fromARGB(255, 128, 57, 155),
          Color.fromARGB(255, 146, 40, 123),
        ];
      case 65:
        return const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 1, 1, 1),
          Color.fromARGB(255, 5, 5, 6),
          Color.fromARGB(255, 5, 5, 6),
          Color.fromARGB(255, 10, 1, 12),
          Color.fromARGB(255, 0, 0, 0),
        ];
      case 40:
        return const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 0, 0, 45),
          Color.fromARGB(255, 0, 0, 255),
          Color.fromARGB(255, 42, 0, 255),
          Color.fromARGB(255, 255, 0, 255),
          Color.fromARGB(255, 255, 55, 255),
          Color.fromARGB(255, 255, 255, 255),
        ];
      case 41:
        return const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 42, 0, 45),
          Color.fromARGB(255, 255, 0, 255),
          Color.fromARGB(255, 255, 0, 45),
          Color.fromARGB(255, 255, 0, 0),
        ];
      case 9:
        return const [
          Color.fromARGB(255, 25, 25, 112),
          Color.fromARGB(255, 0, 0, 139),
          Color.fromARGB(255, 25, 25, 112),
          Color.fromARGB(255, 0, 0, 128),
          Color.fromARGB(255, 0, 0, 139),
          Color.fromARGB(255, 0, 0, 205),
          Color.fromARGB(255, 46, 139, 87),
          Color.fromARGB(255, 0, 128, 128),
          Color.fromARGB(255, 95, 158, 160),
          Color.fromARGB(255, 0, 0, 255),
          Color.fromARGB(255, 0, 139, 139),
          Color.fromARGB(255, 100, 149, 237),
          Color.fromARGB(255, 127, 255, 212),
          Color.fromARGB(255, 46, 139, 87),
          Color.fromARGB(255, 0, 255, 255),
          Color.fromARGB(255, 135, 206, 250),
        ];
      case 44:
        return const [
          Color.fromARGB(255, 0, 150, 92),
          Color.fromARGB(255, 0, 150, 92),
          Color.fromARGB(255, 255, 72, 0),
          Color.fromARGB(255, 255, 72, 0),
        ];

      case 47:
        return const [
          Color.fromARGB(255, 255, 95, 23),
          Color.fromARGB(255, 255, 82, 0),
          Color.fromARGB(255, 223, 13, 8),
          Color.fromARGB(255, 144, 44, 2),
          Color.fromARGB(255, 255, 110, 17),
          Color.fromARGB(255, 255, 69, 0),
          Color.fromARGB(255, 158, 13, 11),
          Color.fromARGB(255, 241, 82, 17),
          Color.fromARGB(255, 213, 37, 4),
        ];
      case 6:
        return const [
          Color.fromARGB(255, 85, 0, 171),
          Color.fromARGB(255, 132, 0, 124),
          Color.fromARGB(255, 181, 0, 75),
          Color.fromARGB(255, 229, 0, 27),
          Color.fromARGB(255, 232, 23, 0),
          Color.fromARGB(255, 184, 71, 0),
          Color.fromARGB(255, 171, 119, 0),
          Color.fromARGB(255, 171, 171, 0),
          Color.fromARGB(255, 171, 85, 0),
          Color.fromARGB(255, 221, 34, 0),
          Color.fromARGB(255, 242, 0, 14),
          Color.fromARGB(255, 194, 0, 62),
          Color.fromARGB(255, 143, 0, 113),
          Color.fromARGB(255, 95, 0, 161),
          Color.fromARGB(255, 47, 0, 208),
          Color.fromARGB(255, 0, 7, 249),
        ];
      case 20:
        return const [
          Color.fromARGB(255, 10, 62, 123),
          Color.fromARGB(255, 56, 130, 103),
          Color.fromARGB(255, 153, 225, 85),
          Color.fromARGB(255, 199, 217, 68),
          Color.fromARGB(255, 255, 207, 54),
          Color.fromARGB(255, 247, 152, 57),
          Color.fromARGB(255, 239, 107, 61),
          Color.fromARGB(255, 247, 152, 57),
          Color.fromARGB(255, 255, 207, 54),
          Color.fromARGB(255, 255, 227, 48),
          Color.fromARGB(255, 255, 248, 42),
        ];
      case 61:
        return const [
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 7, 12, 255),
          Color.fromARGB(255, 227, 1, 127),
          Color.fromARGB(255, 227, 1, 127),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 227, 1, 127),
          Color.fromARGB(255, 45, 1, 99),
          Color.fromARGB(255, 255, 255, 255),
        ];
      case 11:
        return const [
          Color.fromARGB(255, 255, 0, 0),
          Color.fromARGB(255, 213, 42, 0),
          Color.fromARGB(255, 171, 85, 0),
          Color.fromARGB(255, 171, 127, 0),
          Color.fromARGB(255, 171, 171, 0),
          Color.fromARGB(255, 86, 213, 0),
          Color.fromARGB(255, 0, 255, 0),
          Color.fromARGB(255, 0, 213, 42),
          Color.fromARGB(255, 0, 171, 85),
          Color.fromARGB(255, 0, 86, 170),
          Color.fromARGB(255, 0, 0, 255),
          Color.fromARGB(255, 42, 0, 213),
          Color.fromARGB(255, 85, 0, 171),
          Color.fromARGB(255, 127, 0, 129),
          Color.fromARGB(255, 171, 0, 85),
          Color.fromARGB(255, 213, 0, 43),
        ];
      case 12:
        return const [
          Color.fromARGB(255, 255, 0, 0),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 171, 85, 0),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 171, 171, 0),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 0, 255, 0),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 0, 171, 85),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 0, 0, 255),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 85, 0, 171),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 171, 0, 85),
          Color.fromARGB(255, 0, 0, 0),
        ];
      case 16:
        return const [
          Color.fromARGB(255, 4, 1, 70),
          Color.fromARGB(255, 55, 1, 30),
          Color.fromARGB(255, 255, 4, 7),
          Color.fromARGB(255, 59, 2, 29),
          Color.fromARGB(255, 11, 3, 50),
          Color.fromARGB(255, 39, 8, 60),
          Color.fromARGB(255, 112, 19, 40),
          Color.fromARGB(255, 78, 11, 39),
          Color.fromARGB(255, 29, 8, 59),
        ];
      case 66:
        return const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 227, 1, 1),
          Color.fromARGB(255, 249, 199, 95),
          Color.fromARGB(255, 227, 1, 1),
          Color.fromARGB(255, 0, 0, 0),
        ];
      case 62:
        return const [
          Color.fromARGB(255, 3, 13, 43),
          Color.fromARGB(255, 78, 141, 240),
          Color.fromARGB(255, 255, 0, 0),
          Color.fromARGB(255, 28, 1, 1),
        ];
      case 68:
        return const [
          Color.fromARGB(255, 31, 1, 27),
          Color.fromARGB(255, 34, 1, 16),
          Color.fromARGB(255, 137, 5, 9),
          Color.fromARGB(255, 213, 128, 10),
          Color.fromARGB(255, 199, 22, 1),
          Color.fromARGB(255, 199, 9, 6),
          Color.fromARGB(255, 1, 0, 1),
        ];
      case 69:
        return const [
          Color.fromARGB(255, 247, 5, 0),
          Color.fromARGB(255, 255, 67, 1),
          Color.fromARGB(255, 234, 88, 11),
          Color.fromARGB(255, 234, 176, 51),
          Color.fromARGB(255, 229, 28, 1),
          Color.fromARGB(255, 113, 12, 1),
          Color.fromARGB(255, 255, 225, 44),
          Color.fromARGB(255, 113, 12, 1),
          Color.fromARGB(255, 244, 209, 88),
          Color.fromARGB(255, 255, 28, 1),
          Color.fromARGB(255, 53, 1, 1),
        ];
      case 56:
        return const [
          Color.fromARGB(255, 227, 101, 3),
          Color.fromARGB(255, 194, 18, 19),
          Color.fromARGB(255, 92, 8, 192),
        ];
      case 33:
        return const [
          Color.fromARGB(255, 113, 91, 147),
          Color.fromARGB(255, 157, 88, 78),
          Color.fromARGB(255, 208, 85, 33),
          Color.fromARGB(255, 255, 29, 11),
          Color.fromARGB(255, 137, 31, 39),
          Color.fromARGB(255, 59, 33, 89),
        ];
      case 14:
        return const [
          Color.fromARGB(255, 1, 14, 5),
          Color.fromARGB(255, 16, 36, 14),
          Color.fromARGB(255, 56, 68, 30),
          Color.fromARGB(255, 150, 156, 99),
          Color.fromARGB(255, 150, 156, 99),
        ];
      case 49:
        return const [
          Color.fromARGB(255, 196, 19, 10),
          Color.fromARGB(255, 255, 69, 45),
          Color.fromARGB(255, 223, 45, 72),
          Color.fromARGB(255, 255, 82, 103),
          Color.fromARGB(255, 223, 13, 17),
        ];

      case 60:
        return const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 1, 1, 3),
          Color.fromARGB(255, 8, 1, 22),
          Color.fromARGB(255, 4, 6, 89),
          Color.fromARGB(255, 2, 25, 216),
          Color.fromARGB(255, 7, 10, 99),
          Color.fromARGB(255, 15, 2, 31),
          Color.fromARGB(255, 2, 1, 5),
          Color.fromARGB(255, 0, 0, 0),
        ];
      case 27:
        return const [
          Color.fromARGB(255, 255, 33, 4),
          Color.fromARGB(255, 255, 68, 25),
          Color.fromARGB(255, 255, 7, 25),
          Color.fromARGB(255, 255, 82, 103),
          Color.fromARGB(255, 255, 255, 242),
          Color.fromARGB(255, 42, 255, 22),
          Color.fromARGB(255, 87, 255, 65),
        ];
      case 19:
        return const [
          Color.fromARGB(255, 126, 11, 255),
          Color.fromARGB(255, 197, 1, 22),
          Color.fromARGB(255, 210, 157, 172),
          Color.fromARGB(255, 157, 3, 112),
          Color.fromARGB(255, 157, 3, 112),
        ];
      case 13:
        return const [
          Color.fromARGB(255, 120, 0, 0),
          Color.fromARGB(255, 179, 22, 0),
          Color.fromARGB(255, 255, 104, 0),
          Color.fromARGB(255, 167, 22, 18),
          Color.fromARGB(255, 100, 0, 103),
          Color.fromARGB(255, 16, 0, 130),
          Color.fromARGB(255, 0, 0, 160),
        ];
      case 21:
        return const [
          Color.fromARGB(255, 110, 49, 11),
          Color.fromARGB(255, 55, 34, 10),
          Color.fromARGB(255, 22, 22, 9),
          Color.fromARGB(255, 239, 124, 8),
          Color.fromARGB(255, 220, 156, 27),
          Color.fromARGB(255, 203, 193, 61),
          Color.fromARGB(255, 33, 53, 56),
          Color.fromARGB(255, 0, 1, 52),
        ];
      case 54:
        return const [
          Color.fromARGB(255, 1, 27, 105),
          Color.fromARGB(255, 1, 40, 127),
          Color.fromARGB(255, 1, 70, 168),
          Color.fromARGB(255, 1, 92, 197),
          Color.fromARGB(255, 1, 119, 221),
          Color.fromARGB(255, 3, 130, 151),
          Color.fromARGB(255, 23, 156, 149),
          Color.fromARGB(255, 67, 182, 112),
          Color.fromARGB(255, 121, 201, 52),
          Color.fromARGB(255, 142, 203, 11),
          Color.fromARGB(255, 224, 223, 1),
          Color.fromARGB(255, 252, 187, 2),
          Color.fromARGB(255, 247, 147, 1),
          Color.fromARGB(255, 237, 87, 1),
          Color.fromARGB(255, 229, 43, 1),
          Color.fromARGB(255, 171, 2, 2),
          Color.fromARGB(255, 80, 3, 3),
          Color.fromARGB(255, 80, 3, 3),
        ];
      case 34:
        return const [
          Color.fromARGB(255, 0, 1, 255),
          Color.fromARGB(255, 3, 68, 45),
          Color.fromARGB(255, 23, 255, 0),
          Color.fromARGB(255, 100, 68, 1),
          Color.fromARGB(255, 255, 1, 4),
        ];
      case 45:
        return const [
          Color.fromARGB(255, 1, 2, 14),
          Color.fromARGB(255, 2, 5, 35),
          Color.fromARGB(255, 13, 135, 92),
          Color.fromARGB(255, 43, 255, 193),
          Color.fromARGB(255, 247, 7, 249),
          Color.fromARGB(255, 193, 17, 208),
          Color.fromARGB(255, 39, 255, 154),
          Color.fromARGB(255, 4, 213, 236),
          Color.fromARGB(255, 39, 252, 135),
          Color.fromARGB(255, 193, 213, 253),
          Color.fromARGB(255, 255, 249, 255),
        ];
      case 58:
        return const [
          Color.fromARGB(255, 1, 221, 53),
          Color.fromARGB(255, 73, 3, 178),
        ];
      case 23:
        return const [
          Color.fromARGB(255, 4, 1, 1),
          Color.fromARGB(255, 16, 0, 1),
          Color.fromARGB(255, 97, 104, 3),
          Color.fromARGB(255, 255, 131, 19),
          Color.fromARGB(255, 67, 9, 4),
          Color.fromARGB(255, 16, 0, 1),
          Color.fromARGB(255, 4, 1, 1),
          Color.fromARGB(255, 4, 1, 1),
        ];
      case 43:
        return const [
          Color.fromARGB(255, 0, 0, 255),
          Color.fromARGB(255, 0, 55, 255),
          Color.fromARGB(255, 0, 255, 255),
          Color.fromARGB(255, 42, 255, 45),
          Color.fromARGB(255, 255, 255, 0),
        ];
      case 64:
        return const [
          Color.fromARGB(255, 4, 2, 9),
          Color.fromARGB(255, 16, 0, 47),
          Color.fromARGB(255, 24, 0, 16),
          Color.fromARGB(255, 144, 9, 1),
          Color.fromARGB(255, 179, 45, 1),
          Color.fromARGB(255, 220, 114, 2),
          Color.fromARGB(255, 234, 237, 1),
        ];
      case 17:
        return const [
          Color.fromARGB(255, 188, 135, 1),
          Color.fromARGB(255, 46, 7, 1),
        ];
      case 42:
        return const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 42, 0, 0),
          Color.fromARGB(255, 255, 0, 0),
          Color.fromARGB(255, 255, 0, 45),
          Color.fromARGB(255, 255, 0, 255),
          Color.fromARGB(255, 255, 55, 45),
          Color.fromARGB(255, 255, 255, 0),
        ];

      default:
        return const [
          Color(0xFF00FF00),
          Color(0xFF0000FF),
        ];
    }
  }
}
