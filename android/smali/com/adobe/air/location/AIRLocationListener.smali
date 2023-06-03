.class public Lcom/adobe/air/location/AIRLocationListener;
.super Ljava/lang/Object;
.source "AIRLocationListener.java"

# interfaces
.implements Landroid/location/LocationListener;


# static fields
.field private static final TIMEOUT_INTERVAL:I = 0x3a98


# instance fields
.field private m_geoObj:Lcom/adobe/air/location/Geolocation;


# direct methods
.method public constructor <init>(Lcom/adobe/air/location/Geolocation;)V
    .locals 0
    .param p1, "geoObj"    # Lcom/adobe/air/location/Geolocation;

    .prologue
    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    iput-object p1, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    .line 42
    return-void
.end method

.method private isRegionFullyContained(DDFDDF)Z
    .locals 11
    .param p1, "lat1"    # D
    .param p3, "long1"    # D
    .param p5, "accuracy1"    # F
    .param p6, "lat2"    # D
    .param p8, "long2"    # D
    .param p10, "accuracy2"    # F

    .prologue
    .line 195
    const/4 v0, 0x5

    new-array v8, v0, [F

    .local v8, "results":[F
    move-wide v0, p1

    move-wide v2, p3

    move-wide/from16 v4, p6

    move-wide/from16 v6, p8

    .line 196
    invoke-static/range {v0 .. v8}, Landroid/location/Location;->distanceBetween(DDDD[F)V

    .line 197
    const/4 v0, 0x0

    aget v10, v8, v0

    .line 198
    .local v10, "distanceBetweenCentres":F
    sub-float v0, p10, p5

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v9

    .line 200
    .local v9, "differenceOfRadii":F
    cmpg-float v0, v10, v9

    if-gtz v0, :cond_0

    .line 201
    const/4 v0, 0x1

    .line 203
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public onLocationChanged(Landroid/location/Location;)V
    .locals 25
    .param p1, "locData"    # Landroid/location/Location;

    .prologue
    .line 46
    if-eqz p1, :cond_1

    .line 48
    invoke-virtual/range {p1 .. p1}, Landroid/location/Location;->getProvider()Ljava/lang/String;

    move-result-object v24

    .line 50
    .local v24, "provider":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-object v2, v2, Lcom/adobe/air/location/Geolocation;->m_currentTime:Landroid/text/format/Time;

    invoke-virtual {v2}, Landroid/text/format/Time;->setToNow()V

    .line 52
    invoke-virtual/range {p1 .. p1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v16

    .line 53
    .local v16, "aLatitude":D
    invoke-virtual/range {p1 .. p1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v18

    .line 54
    .local v18, "aLongitude":D
    invoke-virtual/range {p1 .. p1}, Landroid/location/Location;->getAltitude()D

    move-result-wide v14

    .line 56
    .local v14, "aAltitude":D
    invoke-virtual/range {p1 .. p1}, Landroid/location/Location;->getAccuracy()F

    move-result v13

    .line 57
    .local v13, "aHorizontalAaccuracy":F
    invoke-virtual/range {p1 .. p1}, Landroid/location/Location;->getAccuracy()F

    move-result v21

    .line 58
    .local v21, "aVerticalAccuracy":F
    invoke-virtual/range {p1 .. p1}, Landroid/location/Location;->getSpeed()F

    move-result v20

    .line 59
    .local v20, "aSpeed":F
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-object v2, v2, Lcom/adobe/air/location/Geolocation;->m_currentTime:Landroid/text/format/Time;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/text/format/Time;->toMillis(Z)J

    move-result-wide v22

    .line 63
    .local v22, "aTimestamp":J
    const-string v2, "gps"

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_2

    .line 65
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    const/4 v3, 0x0

    iput-boolean v3, v2, Lcom/adobe/air/location/Geolocation;->m_ignoreLastGPSValue:Z

    .line 67
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move-wide/from16 v0, v16

    iput-wide v0, v2, Lcom/adobe/air/location/Geolocation;->m_gpsLatitude:D

    .line 68
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move-wide/from16 v0, v18

    iput-wide v0, v2, Lcom/adobe/air/location/Geolocation;->m_gpsLongitude:D

    .line 69
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iput-wide v14, v2, Lcom/adobe/air/location/Geolocation;->m_gpsAltitude:D

    .line 70
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iput v13, v2, Lcom/adobe/air/location/Geolocation;->m_gpsHorizontalAaccuracy:F

    .line 71
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move/from16 v0, v21

    iput v0, v2, Lcom/adobe/air/location/Geolocation;->m_gpsVerticalAccuracy:F

    .line 72
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move/from16 v0, v20

    iput v0, v2, Lcom/adobe/air/location/Geolocation;->m_gpsSpeed:F

    .line 73
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-object v3, v3, Lcom/adobe/air/location/Geolocation;->m_currentTime:Landroid/text/format/Time;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/text/format/Time;->toMillis(Z)J

    move-result-wide v4

    iput-wide v4, v2, Lcom/adobe/air/location/Geolocation;->m_gpsTimestamp:J

    .line 112
    :cond_0
    :goto_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move-wide/from16 v0, v16

    iput-wide v0, v2, Lcom/adobe/air/location/Geolocation;->m_latitude:D

    .line 113
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move-wide/from16 v0, v18

    iput-wide v0, v2, Lcom/adobe/air/location/Geolocation;->m_longitude:D

    .line 114
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iput-wide v14, v2, Lcom/adobe/air/location/Geolocation;->m_altitude:D

    .line 115
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iput v13, v2, Lcom/adobe/air/location/Geolocation;->m_horizontalAaccuracy:F

    .line 116
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move/from16 v0, v21

    iput v0, v2, Lcom/adobe/air/location/Geolocation;->m_verticalAccuracy:F

    .line 117
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move/from16 v0, v20

    iput v0, v2, Lcom/adobe/air/location/Geolocation;->m_speed:F

    .line 118
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move-wide/from16 v0, v22

    iput-wide v0, v2, Lcom/adobe/air/location/Geolocation;->m_timestamp:J

    .line 123
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_EventSourceExists:Z

    if-eqz v2, :cond_1

    .line 126
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-wide v4, v3, Lcom/adobe/air/location/Geolocation;->m_objectPointer:J

    invoke-virtual {v2, v4, v5}, Lcom/adobe/air/location/Geolocation;->updateGeolocationCache(J)V

    .line 133
    .end local v13    # "aHorizontalAaccuracy":F
    .end local v14    # "aAltitude":D
    .end local v16    # "aLatitude":D
    .end local v18    # "aLongitude":D
    .end local v20    # "aSpeed":F
    .end local v21    # "aVerticalAccuracy":F
    .end local v22    # "aTimestamp":J
    .end local v24    # "provider":Ljava/lang/String;
    :cond_1
    return-void

    .line 75
    .restart local v13    # "aHorizontalAaccuracy":F
    .restart local v14    # "aAltitude":D
    .restart local v16    # "aLatitude":D
    .restart local v18    # "aLongitude":D
    .restart local v20    # "aSpeed":F
    .restart local v21    # "aVerticalAccuracy":F
    .restart local v22    # "aTimestamp":J
    .restart local v24    # "provider":Ljava/lang/String;
    :cond_2
    const-string v2, "network"

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_0

    .line 77
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move-wide/from16 v0, v16

    iput-wide v0, v2, Lcom/adobe/air/location/Geolocation;->m_networkLatitude:D

    .line 78
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move-wide/from16 v0, v18

    iput-wide v0, v2, Lcom/adobe/air/location/Geolocation;->m_networkLongitude:D

    .line 79
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iput-wide v14, v2, Lcom/adobe/air/location/Geolocation;->m_networkAltitude:D

    .line 80
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iput v13, v2, Lcom/adobe/air/location/Geolocation;->m_networkHorizontalAaccuracy:F

    .line 81
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move/from16 v0, v21

    iput v0, v2, Lcom/adobe/air/location/Geolocation;->m_networkVerticalAccuracy:F

    .line 82
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move/from16 v0, v20

    iput v0, v2, Lcom/adobe/air/location/Geolocation;->m_networkSpeed:F

    .line 83
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-object v3, v3, Lcom/adobe/air/location/Geolocation;->m_currentTime:Landroid/text/format/Time;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/text/format/Time;->toMillis(Z)J

    move-result-wide v4

    iput-wide v4, v2, Lcom/adobe/air/location/Geolocation;->m_networkTimestamp:J

    .line 89
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_ignoreLastGPSValue:Z

    if-nez v2, :cond_3

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-wide v2, v2, Lcom/adobe/air/location/Geolocation;->m_networkTimestamp:J

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-wide v4, v4, Lcom/adobe/air/location/Geolocation;->m_gpsTimestamp:J

    sub-long/2addr v2, v4

    const-wide/16 v4, 0x3a98

    cmp-long v2, v2, v4

    if-gez v2, :cond_3

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget v2, v2, Lcom/adobe/air/location/Geolocation;->m_networkHorizontalAaccuracy:F

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget v3, v3, Lcom/adobe/air/location/Geolocation;->m_gpsHorizontalAaccuracy:F

    cmpl-float v2, v2, v3

    if-lez v2, :cond_3

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-wide v3, v2, Lcom/adobe/air/location/Geolocation;->m_gpsLatitude:D

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-wide v5, v2, Lcom/adobe/air/location/Geolocation;->m_gpsLongitude:D

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget v7, v2, Lcom/adobe/air/location/Geolocation;->m_gpsHorizontalAaccuracy:F

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-wide v8, v2, Lcom/adobe/air/location/Geolocation;->m_networkLatitude:D

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-wide v10, v2, Lcom/adobe/air/location/Geolocation;->m_networkLongitude:D

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget v12, v2, Lcom/adobe/air/location/Geolocation;->m_networkHorizontalAaccuracy:F

    move-object/from16 v2, p0

    .line 93
    invoke-direct/range {v2 .. v12}, Lcom/adobe/air/location/AIRLocationListener;->isRegionFullyContained(DDFDDF)Z

    move-result v2

    if-nez v2, :cond_1

    .line 103
    :cond_3
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    const/4 v3, 0x1

    iput-boolean v3, v2, Lcom/adobe/air/location/Geolocation;->m_ignoreLastGPSValue:Z

    goto/16 :goto_0
.end method

.method public onProviderDisabled(Ljava/lang/String;)V
    .locals 7
    .param p1, "arg0"    # Ljava/lang/String;

    .prologue
    const/4 v6, 0x0

    .line 136
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v0, v2, Lcom/adobe/air/location/Geolocation;->m_isGPSProviderEnabled:Z

    .line 137
    .local v0, "wasGPSEnabled":Z
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v1, v2, Lcom/adobe/air/location/Geolocation;->m_isNetworkProviderEnabled:Z

    .line 141
    .local v1, "wasNetworkEnabled":Z
    const-string v2, "gps"

    invoke-virtual {p1, v2}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_2

    .line 142
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iput-boolean v6, v2, Lcom/adobe/air/location/Geolocation;->m_isGPSProviderEnabled:Z

    .line 149
    :cond_0
    :goto_0
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_isGPSProviderEnabled:Z

    if-ne v0, v2, :cond_3

    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_isNetworkProviderEnabled:Z

    if-ne v1, v2, :cond_3

    .line 158
    :cond_1
    :goto_1
    return-void

    .line 143
    :cond_2
    const-string v2, "network"

    invoke-virtual {p1, v2}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_0

    .line 144
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iput-boolean v6, v2, Lcom/adobe/air/location/Geolocation;->m_isNetworkProviderEnabled:Z

    goto :goto_0

    .line 153
    :cond_3
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_EventSourceExists:Z

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_isGPSProviderEnabled:Z

    if-nez v2, :cond_1

    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_isNetworkProviderEnabled:Z

    if-nez v2, :cond_1

    .line 156
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-object v3, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-wide v4, v3, Lcom/adobe/air/location/Geolocation;->m_objectPointer:J

    invoke-virtual {v2, v6, v4, v5}, Lcom/adobe/air/location/Geolocation;->setGeolocationStatus(ZJ)V

    goto :goto_1
.end method

.method public onProviderEnabled(Ljava/lang/String;)V
    .locals 7
    .param p1, "arg0"    # Ljava/lang/String;

    .prologue
    const/4 v6, 0x1

    .line 161
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v0, v2, Lcom/adobe/air/location/Geolocation;->m_isGPSProviderEnabled:Z

    .line 162
    .local v0, "wasGPSEnabled":Z
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v1, v2, Lcom/adobe/air/location/Geolocation;->m_isNetworkProviderEnabled:Z

    .line 166
    .local v1, "wasNetworkEnabled":Z
    const-string v2, "gps"

    invoke-virtual {p1, v2}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_1

    .line 168
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iput-boolean v6, v2, Lcom/adobe/air/location/Geolocation;->m_isGPSProviderEnabled:Z

    .line 169
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_EventSourceExists:Z

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_isNetworkProviderEnabled:Z

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_isGPSProviderEnabled:Z

    if-eq v0, v2, :cond_0

    .line 172
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-object v3, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-wide v4, v3, Lcom/adobe/air/location/Geolocation;->m_objectPointer:J

    invoke-virtual {v2, v6, v4, v5}, Lcom/adobe/air/location/Geolocation;->setGeolocationStatus(ZJ)V

    .line 186
    :cond_0
    :goto_0
    return-void

    .line 175
    :cond_1
    const-string v2, "network"

    invoke-virtual {p1, v2}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_0

    .line 177
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iput-boolean v6, v2, Lcom/adobe/air/location/Geolocation;->m_isNetworkProviderEnabled:Z

    .line 178
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_EventSourceExists:Z

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_isGPSProviderEnabled:Z

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-boolean v2, v2, Lcom/adobe/air/location/Geolocation;->m_isNetworkProviderEnabled:Z

    if-eq v1, v2, :cond_0

    .line 181
    iget-object v2, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-object v3, p0, Lcom/adobe/air/location/AIRLocationListener;->m_geoObj:Lcom/adobe/air/location/Geolocation;

    iget-wide v4, v3, Lcom/adobe/air/location/Geolocation;->m_objectPointer:J

    invoke-virtual {v2, v6, v4, v5}, Lcom/adobe/air/location/Geolocation;->setGeolocationStatus(ZJ)V

    goto :goto_0
.end method

.method public onStatusChanged(Ljava/lang/String;ILandroid/os/Bundle;)V
    .locals 0
    .param p1, "arg0"    # Ljava/lang/String;
    .param p2, "arg1"    # I
    .param p3, "arg2"    # Landroid/os/Bundle;

    .prologue
    .line 190
    return-void
.end method
