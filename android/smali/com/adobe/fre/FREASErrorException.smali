.class public Lcom/adobe/fre/FREASErrorException;
.super Ljava/lang/Exception;
.source "FREASErrorException.java"


# static fields
.field public static final serialVersionUID:J = 0x1L


# instance fields
.field private m_thrownASException:Lcom/adobe/fre/FREObject;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Exception;-><init>()V

    return-void
.end method


# virtual methods
.method public getThrownException()Lcom/adobe/fre/FREObject;
    .locals 1

    .prologue
    .line 26
    iget-object v0, p0, Lcom/adobe/fre/FREASErrorException;->m_thrownASException:Lcom/adobe/fre/FREObject;

    return-object v0
.end method
