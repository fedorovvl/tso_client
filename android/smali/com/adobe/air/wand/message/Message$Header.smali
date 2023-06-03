.class public abstract Lcom/adobe/air/wand/message/Message$Header;
.super Ljava/lang/Object;
.source "Message.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/message/Message;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Header"
.end annotation


# instance fields
.field protected mTimestamp:J

.field protected mTitle:Ljava/lang/String;

.field protected mType:Lcom/adobe/air/wand/message/Message$Type;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lcom/adobe/air/wand/message/Message$Type;J)V
    .locals 3
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "type"    # Lcom/adobe/air/wand/message/Message$Type;
    .param p3, "timestamp"    # J

    .prologue
    const/4 v0, 0x0

    .line 62
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 51
    iput-object v0, p0, Lcom/adobe/air/wand/message/Message$Header;->mTitle:Ljava/lang/String;

    .line 56
    iput-object v0, p0, Lcom/adobe/air/wand/message/Message$Header;->mType:Lcom/adobe/air/wand/message/Message$Type;

    .line 60
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/adobe/air/wand/message/Message$Header;->mTimestamp:J

    .line 63
    iput-object p1, p0, Lcom/adobe/air/wand/message/Message$Header;->mTitle:Ljava/lang/String;

    .line 64
    iput-object p2, p0, Lcom/adobe/air/wand/message/Message$Header;->mType:Lcom/adobe/air/wand/message/Message$Type;

    .line 65
    iput-wide p3, p0, Lcom/adobe/air/wand/message/Message$Header;->mTimestamp:J

    .line 66
    return-void
.end method


# virtual methods
.method public getTimestamp()J
    .locals 2

    .prologue
    .line 77
    iget-wide v0, p0, Lcom/adobe/air/wand/message/Message$Header;->mTimestamp:J

    return-wide v0
.end method

.method public getTitle()Ljava/lang/String;
    .locals 1

    .prologue
    .line 69
    iget-object v0, p0, Lcom/adobe/air/wand/message/Message$Header;->mTitle:Ljava/lang/String;

    return-object v0
.end method

.method public getType()Lcom/adobe/air/wand/message/Message$Type;
    .locals 1

    .prologue
    .line 73
    iget-object v0, p0, Lcom/adobe/air/wand/message/Message$Header;->mType:Lcom/adobe/air/wand/message/Message$Type;

    return-object v0
.end method

.method public setTimestamp(J)V
    .locals 1
    .param p1, "timestamp"    # J

    .prologue
    .line 89
    iput-wide p1, p0, Lcom/adobe/air/wand/message/Message$Header;->mTimestamp:J

    .line 90
    return-void
.end method

.method public setTitle(Ljava/lang/String;)V
    .locals 0
    .param p1, "title"    # Ljava/lang/String;

    .prologue
    .line 81
    iput-object p1, p0, Lcom/adobe/air/wand/message/Message$Header;->mTitle:Ljava/lang/String;

    .line 82
    return-void
.end method

.method public setType(Lcom/adobe/air/wand/message/Message$Type;)V
    .locals 0
    .param p1, "type"    # Lcom/adobe/air/wand/message/Message$Type;

    .prologue
    .line 85
    iput-object p1, p0, Lcom/adobe/air/wand/message/Message$Header;->mType:Lcom/adobe/air/wand/message/Message$Type;

    .line 86
    return-void
.end method
