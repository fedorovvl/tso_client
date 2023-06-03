.class public Lcom/adobe/air/net/NetworkInterface;
.super Ljava/lang/Object;
.source "NetworkInterface.java"


# instance fields
.field public active:Z

.field private addresses:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<",
            "Lcom/adobe/air/net/InterfaceAddress;",
            ">;"
        }
    .end annotation
.end field

.field public displayName:Ljava/lang/String;

.field public hardwareAddress:Ljava/lang/String;

.field public mtu:I

.field public name:Ljava/lang/String;

.field public parent:Lcom/adobe/air/net/NetworkInterface;

.field public subInterfaces:Lcom/adobe/air/net/NetworkInterface;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/net/NetworkInterface;->active:Z

    .line 19
    const-string v0, ""

    iput-object v0, p0, Lcom/adobe/air/net/NetworkInterface;->displayName:Ljava/lang/String;

    .line 20
    const-string v0, ""

    iput-object v0, p0, Lcom/adobe/air/net/NetworkInterface;->hardwareAddress:Ljava/lang/String;

    .line 21
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/net/NetworkInterface;->mtu:I

    .line 22
    const-string v0, ""

    iput-object v0, p0, Lcom/adobe/air/net/NetworkInterface;->name:Ljava/lang/String;

    .line 23
    iput-object v1, p0, Lcom/adobe/air/net/NetworkInterface;->parent:Lcom/adobe/air/net/NetworkInterface;

    .line 24
    iput-object v1, p0, Lcom/adobe/air/net/NetworkInterface;->subInterfaces:Lcom/adobe/air/net/NetworkInterface;

    .line 25
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/net/NetworkInterface;->addresses:Ljava/util/Vector;

    .line 26
    return-void
.end method


# virtual methods
.method public GetAddress(I)Lcom/adobe/air/net/InterfaceAddress;
    .locals 1
    .param p1, "i"    # I

    .prologue
    .line 40
    iget-object v0, p0, Lcom/adobe/air/net/NetworkInterface;->addresses:Ljava/util/Vector;

    invoke-virtual {v0, p1}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/net/InterfaceAddress;

    return-object v0
.end method

.method public GetAddressesCount()I
    .locals 1

    .prologue
    .line 35
    iget-object v0, p0, Lcom/adobe/air/net/NetworkInterface;->addresses:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    return v0
.end method

.method public addAddress(Lcom/adobe/air/net/InterfaceAddress;)V
    .locals 1
    .param p1, "address"    # Lcom/adobe/air/net/InterfaceAddress;

    .prologue
    .line 30
    iget-object v0, p0, Lcom/adobe/air/net/NetworkInterface;->addresses:Ljava/util/Vector;

    invoke-virtual {v0, p1}, Ljava/util/Vector;->add(Ljava/lang/Object;)Z

    .line 31
    return-void
.end method
